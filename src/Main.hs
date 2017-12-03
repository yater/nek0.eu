--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import Hakyll
import Data.Monoid       ((<>))
import Data.List
import Data.Maybe        (fromMaybe)
import Data.Time.Format  (parseTimeM, defaultTimeLocale)
import Data.Time.Clock   (UTCTime)
import System.FilePath   (takeFileName)
import Network.HTTP.Base (urlEncode)
import Control.Monad     (liftM)


--------------------------------------------------------------------------------
main :: IO ()
main =

  hakyllWith config $ do

    match "templates/*" $ compile templateCompiler

    --copy fonts, images etc.
    match
      (    "site/font/*"
      .||. "site/images/*"
      .||. "site/humans.txt"
      .||. "site/94A943E0.asc"
      .||. "site/robots.txt"
      .||. "site/keybase.txt"
      ) $ do
        route   myRoute
        compile copyFileCompiler

    match "site/css/*" $ do
      route   myRoute
      compile compressCssCompiler

    -- Build tags
    tags <- buildTags "site/posts/*.md" (fromCapture "tags/*.html")

    --build tagcloud
    let baseCtx = tagCloudField "tagcloud" 80.0 200.0 tags <>
                defaultContext

    match "site/index.md" $ do
      route $ myRoute `composeRoutes` setExtension "html"
      compile $ do
        posts <- fmap (take 5) . recentFirst =<< loadAll "posts/*"
        let indexCtx = listField "posts" (postCtx tags) (return posts) <>
                       constField "title" "Home" <>
                       defaultContext
        getResourceBody
          >>= applyAsTemplate indexCtx
          >>= renderPandoc
          >>= loadAndApplyTemplate "templates/default.html" baseCtx
          >>= relativizeUrls

    match (fromList
      [ "site/about.md"
      , "site/imprint.md"
      , "site/contact.md"
      ]) $ do
        route   $ myRoute `composeRoutes` setExtension "html"
        compile $ pandocCompiler
          >>= loadAndApplyTemplate "templates/default.html" baseCtx
          >>= relativizeUrls

    match "site/404.md" $ do
      route   $ myRoute `composeRoutes` setExtension "html"
      compile $ pandocCompiler
        >>= loadAndApplyTemplate "templates/default.html" baseCtx

    is <- sortIdentifiersByDate <$> getMatches "site/posts/*.md"

    pages <- buildPaginateWith
      (liftM (paginateEvery 1) . sortRecentFirst)
      "site/posts/*.md"
      (\n -> is !! (n - 1))

    paginateRules pages $ \num _ -> do
      route $ myRoute `composeRoutes` setExtension "html"
      compile $ do
        ident <- getUnderlying
        title <- getMetadataField' ident "title"
        url <- return . fromMaybe "" =<< getRoute ident
        compiled <- getResourceBody >>= renderPandoc
        let pageCtx = paginateContext pages num
        let flattrCtx = constField "enctitle" (urlEncode title) <>
                        constField "encurl"   (urlEncode $ "https://nek0.eu/" ++ url)
        let ctx = (postCtx tags) <> pageCtx <> flattrCtx
        full <- loadAndApplyTemplate "templates/post.html" ctx compiled
        _ <- saveSnapshot "content" compiled
        loadAndApplyTemplate "templates/default.html" baseCtx full
          >>= relativizeUrls

    -- Post tags
    tagsRules tags $ \tag pattern -> do
      let title = "Posts tagged " ++ tag ++ ":"
      -- Copied from posts, need to refactor
      route myRoute
      compile $ do
        posts <- recentFirst =<< loadAll pattern
        let ctx = constField "title" title <>
                  listField "posts" (postCtx tags) (return posts) <>
                  baseCtx
        makeItem ""
          >>= loadAndApplyTemplate "templates/post-list.html" ctx
          >>= loadAndApplyTemplate "templates/default.html" ctx
          >>= relativizeUrls

    create ["archive.html"] $ do
      route idRoute
      compile $ do
        posts <- recentFirst =<< loadAll "site/posts/*"
        let archiveCtx = listField "posts" (postCtx tags) (return posts) <>
                         constField "title" "Archives" <>
                         baseCtx
        makeItem ""
          >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
          >>= loadAndApplyTemplate "templates/default.html" archiveCtx
          >>= relativizeUrls

    match "templates/*" $ compile templateCompiler

    -- feeds

    create ["atom.xml"] $ do
      route idRoute
      compile $ do
        loadAllSnapshots "posts/*" "content"
          >>= fmap (take 10) . recentFirst
          >>= renderAtom feedConf feedCtx

    create ["rss.xml"] $ do
      route idRoute
      compile $ do
        loadAllSnapshots "posts/*" "content"
          >>= fmap (take 10) . recentFirst
          >>= renderRss feedConf feedCtx

    create ["sitemap.xml"] $ do
      route idRoute
      compile $ do
        rposts <- loadAll "site/**/*.md"
        rsites <- loadAll "site/*.md"
        -- rtxts <- loadAll "site/*.txt"
        -- rascs <- loadAll "site/*.asc"
        let sites = return (rposts ++ rsites)
        let sitemapCtx = mconcat
              [ listField "entries"
                  (postCtx tags <> constField "host" "https://nek0.eu/")
                  sites
              , constField "host" "https://nek0.eu/"
              , defaultContext
              ]
        makeItem ""
          >>= loadAndApplyTemplate "templates/sitemap.xml" sitemapCtx

--------------------------------------------------------------------------------

sortIdentifiersByDate :: [Identifier] -> [Identifier]
sortIdentifiersByDate =
    sortBy byDate
  where
    byDate id1 id2 =
      let fn1 = takeFileName $ toFilePath id1
          fn2 = takeFileName $ toFilePath id2
          parseTime' fn = parseTimeM True defaultTimeLocale "%Y-%m-%d" $
            intercalate "-" $ take 3 $ splitAll "-" fn
      in compare
           (parseTime' fn1 :: Maybe UTCTime)
           (parseTime' fn2 :: Maybe UTCTime)

--------------------------------------------------------------------------------

postCtx :: Tags -> Context String
postCtx tags = mconcat
  [ modificationTimeField "mtime" "%U"
  , dateField "date" "%B %e, %Y"
  , dateField "datetime" "%F"
  , tagsField "tags" tags
  , defaultContext
  ]

--------------------------------------------------------------------------------

feedCtx :: Context String
feedCtx = mconcat
  [ bodyField "description"
  , defaultContext
  ]

--------------------------------------------------------------------------------

feedConf :: FeedConfiguration
feedConf = FeedConfiguration
  { feedTitle = "nek0's blog"
  , feedDescription = "Random things"
  , feedAuthorName = "nek0"
  , feedAuthorEmail = "nek0@nek0.eu"
  , feedRoot = "https://nek0.eu"
  }

--------------------------------------------------------------------------------

config :: Configuration
config = defaultConfiguration
  { deployCommand = "rsync --del --checksum -ave 'ssh -p 5555' \\_site/* nek0@chelnok.de:/home/nek0/www/blog"
  }

--------------------------------------------------------------------------------

myRoute :: Routes
myRoute = gsubRoute "site/" (const "")
