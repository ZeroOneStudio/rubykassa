## 0.2.4

* Fix naming issue with pay helper: rename 'link_to_pay' to 'pay_url'.

## 0.2.3

* Fix bug with calling incorrect signature validating method in `robokassa_controller#paid`. [#3][]
* Fix bug with signatures comparison. Should compare downcased. [#4][]

[#3]:https://github.com/ZeroOneStudio/rubykassa/issues/3
[#4]:https://github.com/ZeroOneStudio/rubykassa/issues/4

## 0.2.2

* Fix description param name from `'InvDesc'` to `'Desc'`. Closes [#2][]

[#2]: https://github.com/ZeroOneStudio/rubykassa/issues/2
