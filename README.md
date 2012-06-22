#autoencrypt mails

This program is a simple wrapper script for the sendmail command. It encrypts the mails with a predefined key, if the mailheader **X-Please-Encrypt** is set. For Example with: **X-Please-Encrypt: True**

Installing:
You should install gpg and perl with the modules Email::Simple and Crypt::GPG. The modules can be installed with:
```sh
cpanp -i Email::Simple
cpanp -i Crypt::GPG
```

You can find this software on github: https://github.com/ktrask/autoencryptmail
