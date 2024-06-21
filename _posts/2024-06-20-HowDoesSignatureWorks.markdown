---
layout: post
title:  "How does signature works"
date:   2024-06-20 16:14:29 +0800
categories: jekyll update
---

Asymmetric key encryption algorithm use two different keys fro encryption and decryption. The public key and private key.We can use the algorithm in two different ways in actual practice.

| Implementation      | Practice |
| ----------- | ----------- |
| encrypted by pulicKey  decrypted by privateKey       | Transfer data on internet       |
| encrypted by private  decrypted by publicKey   | Signature        |

Today i will explain how does the signature works by using the pirvate key and public key.

1. we use privateKey to encrypt the message to get signature.
2. authenticator get the message and the signature. Then use the standard algorithm function. This function needs two arguments, the message and the signature.
3. compare the result got in second step and the public key. If it is same then we can know this message is signed by the signer.

In this process we must keep the private key in our local machine. We just send the message and the signature. And the other people can use those data to decrypt them and get the publicKey. Pulickey is public to everyone. So by this idea other people can know it is the sender send the message.
