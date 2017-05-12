[![Build Status](https://travis-ci.org/DailyHotel/gauth.svg?branch=master)](https://travis-ci.org/DailyHotel/gauth)
[![](https://images.microbadger.com/badges/image/dailyhotel/golang-glide.svg)](https://microbadger.com/images/dailyhotel/golang-glide "Get your own image badge on microbadger.com")

gauth: replace Google Authenticator
===================================

**ADD ANSI COLOR SUPPORT**

Installation
------------

With Docker already set up, it should be as easy as `docker run dailyhotel/gauth`.

Usage
-----

- In web interfaces, pretend you can't read QR codes, get a secret like `hret 3ij7 kaj4 2jzg` instead.
- Store one secret per line in `gauth.csv`, in the format `name:secret`. For example:

        AWS:   ABCDEFGHIJKLMNOPQRSTUVWXYZ234567ABCDEFGHIJKLMNOPQRSTUVWXYZ234567
        Airbnb:abcd efgh ijkl mnop
        Google:a2b3c4d5e6f7g8h9
        Github:234567qrstuvwxyz

- Run `docker run -v "${PWD}/config:/root/.config" dailyhotel/gauth`. The progress bar indicates how far the next change is.

        $ gauth
                   prev   curr   next
        AWS        315306 135387 483601
        Airbnb     563728 339206 904549
        Google     453564 477615 356846
        Github     911264 548790 784099
        [=======                      ]

- `gauth` is convenient to use in `watch`.

        $ watch --color -n1 -- docker run dailyhotel/gauth

- Remember to keep your system clock synchronized and to **lock your computer when brewing your tea!**

Encryption
----------

`gauth` supports password-based encryption of `gauth.csv`. To encrypt, use:

        $ openssl enc -aes-128-cbc -md sha256 -in gauth.csv -out ~/.config/gauth.csv
        enter aes-128-cbc encryption password:
        Verifying - enter aes-128-cbc encryption password:

`gauth` will then prompt you for that password on every run:

        $ gauth
        Encryption password: 
                   prev   curr   next
        LastPass   915200 479333 408710

Note that this encryption mechanism is far from ideal from a pure security standpoint.
Please read [OpenSSL's notes on the subject](http://www.openssl.org/docs/crypto/EVP_BytesToKey.html#NOTES).

Compatibility
-------------

Tested with:

- Airbnb
- Akamai
- Apple
- AWS
- DreamHost
- Dropbox
- Evernote
- Facebook
- Gandi
- Github
- GoDaddy
- Google
- LastPass
- Linode
- Microsoft
- Okta (reported by Bryan Baldwin)
- WP.com

Please report further results to pierre@gcarrier.fr.

Rooted Android?
---------------

If your Android phone is rooted, it's easy to "back up" your secrets from an `adb shell` into `gauth`.

    # sqlite3 /data/data/com.google.android.apps.authenticator2/databases/database \
              'select email,secret from accounts'

Really, does this make sense?
-----------------------------

At least to me, it does. My laptop features encrypted storage, a stronger authentication mechanism,
and I take good care of its physical integrity.

My phone also runs arbitrary apps, is constantly connected to the Internet, gets forgotten on tables.

Thanks to the convenience of a command line utility, my usage of 2-factor authentication went from
3 to 10 services over a few days.

Clearly a win for security.
