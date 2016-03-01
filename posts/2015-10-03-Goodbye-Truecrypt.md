---
title: Goodbye Truecrypt
author: nek0
tags: english, crypto
description: After long search I finally found an alternative
---

Maybe som of you will remember, that I once [mourned the parting of the truecrypt project][0]. It was the best tool at hand i had to generate encrypted file containers.

I continued to use the software even after the death of its underlying project. Even the audit didn't reveal any critical vulnerabilities. But albeit the thorough search the auditors overlooked two major security bugs in the software, which became buplic just recently.

This sparked another attempt to find an alternative for truecrypt, which I gladly found in [veracrypt][1]. Veracrypt is based on the original code of truecrypt, but under the apache license. They fixed the vulenrabilities pretty quickly after they became public.

The whole user interface reminds me strongly of truecrypt, but they overhauled the encryption and hash functions and the container generations. This means, that veracrypt containers are not compatible with truecrypt, but truecrypt containers can still be mounted in veracrypt, because of a builtin "legacy mode".

[0]: https://nek0.eu/posts/2014-06-13-Crypto-broken.html
[1]: https://veracrypt.codeplex.com/
