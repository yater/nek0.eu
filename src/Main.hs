--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Hakyll
import           Data.Monoid     ((<>), mconcat)
import           Data.List (sort, delete)
import           System.Directory

--------------------------------------------------------------------------------
main :: IO ()
main = do

  fs <- getDirectoryContents "./posts"
  is <- return $ map (fromFilePath . ("posts/" ++)) $ sort $ delete "." $ delete ".." fs

  hakyllWith config $ do

    match "templates/*" $ compile templateCompiler

    --copy fonts, images etc.
    match ("font/*" .||. "images/*" .||. "humans.txt" .||. "D7665688.txt" .||. "robots.txt")  $ do
      route   idRoute
      compile copyFileCompiler

    match "css/*" $ do
      route   idRoute
      compile compressCssCompiler

    -- Build tags
    tags <- buildTags "posts/*.md" (fromCapture "tags/*.html")

    --build tagcloud
    let baseCtx = tagCloudField "tagcloud" 80.0 200.0 tags <>
                defaultContext

    match "about.md" $ do
      route   $ setExtension "html"
      compile $ pandocCompiler
        >>= loadAndApplyTemplate "templates/default.html" baseCtx
        >>= relativizeUrls

    match "404.md" $ do
      route   $ setExtension "html"
      compile $ pandocCompiler
        >>= loadAndApplyTemplate "templates/default.html" baseCtx

    match "imprint.md" $ do
      route $ setExtension "html"
      compile $ pandocCompiler
        >>= loadAndApplyTemplate "templates/default.html" baseCtx
        >>= relativizeUrls

    match "contact.md" $ do
      route   $ setExtension "html"
      compile $ pandocCompiler
        >>= loadAndApplyTemplate "templates/default.html" baseCtx
        >>= relativizeUrls

    pages <- buildPaginateWith
      (return . map return . sort)
      "posts/*.md"
      (\n -> is !! (n - 1))

    paginateRules pages $ \num _ -> do
      route $ setExtension "html"
      compile $ do
        compiled <- getResourceBody >>= myPandoc
        let pageCtx = paginateContext pages num
        let ctx = (postCtx tags) <> pageCtx
        full <- loadAndApplyTemplate "templates/post.html" ctx compiled
        _ <- saveSnapshot "content" compiled
        loadAndApplyTemplate "templates/default.html" baseCtx full
          >>= relativizeUrls

    -- Post tags
    tagsRules tags $ \tag pattern -> do
      let title = "Posts tagged " ++ tag ++ ":"
      -- Copied from posts, need to refactor
      route idRoute
      compile $ do
        posts <- recentFirst =<< loadAll pattern
        let ctx = constField "title" title <>
                  listField "posts" (postCtx tags) (return posts) <>
                  baseCtx
        makeItem ""
          >>= loadAndApplyTemplate "templates/posts.html" ctx
          >>= loadAndApplyTemplate "templates/default.html" ctx
          >>= relativizeUrls

    create ["archive.html"] $ do
      route idRoute
      compile $ do
        posts <- recentFirst =<< loadAll "posts/*"
        let archiveCtx = listField "posts" (postCtx tags) (return posts) <>
                         constField "title" "Archives" <>
                         baseCtx
        makeItem ""
          >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
          >>= loadAndApplyTemplate "templates/default.html" archiveCtx
          >>= relativizeUrls

    match "index.html" $ do
      route idRoute
      compile $ do
        posts <- fmap (take 5) . recentFirst =<< loadAll "posts/*"
        let indexCtx = listField "posts" (postCtx tags) (return posts) <>
                       constField "title" "Home" <>
                       field "tags" (\_ -> renderTagCloud 85.0 300.0 tags) <>
                       defaultContext
        getResourceBody
          >>= applyAsTemplate indexCtx
          >>= loadAndApplyTemplate "templates/default.html" baseCtx
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

--------------------------------------------------------------------------------

postCtx :: Tags -> Context String
postCtx tags = mconcat
  [ modificationTimeField "mtime" "%U"
  , dateField "date" "%B %e, %Y"
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
  , feedRoot = "http://nek0.eu"
  }

--------------------------------------------------------------------------------

config :: Configuration
config = defaultConfiguration
  { deployCommand = "rsync --del --checksum -ave 'ssh -p 5555' \\_site/* nek0@chelnok.de:/home/nek0/www/blog"
  }

--------------------------------------------------------------------------------

myPandoc :: Item String -> Compiler (Item String)
myPandoc item = do
  renderPandocWith defaultHakyllReaderOptions defaultHakyllWriterOptions item
