## Edge (not released)

* Change `XmlInterface` to support dynamic attributes in initialzer, add posibility to use it in test mode by @vidmantas [#23][], [#24][]
* Update base URL to reflect the changes in Robokassa API.
* Allow `pay_url` to accept block
* Hash algorithms implemented (Алгоритм расчёта хэша — http://docs.robokassa.ru/#3733) [#29][]

[#23]:https://github.com/ZeroOneStudio/rubykassa/pull/23
[#24]:https://github.com/ZeroOneStudio/rubykassa/pull/24
[#29]:https://github.com/ZeroOneStudio/rubykassa/pull/29

## 0.4.2

* force converting notification params to `HashWithIndifferentAccess` by @shir [#17][], [#18][]

[#17]:https://github.com/ZeroOneStudio/rubykassa/pull/17
[#18]:https://github.com/ZeroOneStudio/rubykassa/pull/18

## 0.4.1

* Add support html options in params by @JuraSN [#16][]

[#16]:https://github.com/ZeroOneStudio/rubykassa/pull/16

## 0.4.0

* Simplify callbacks logic: no more necessity to pass `controller` variable to lambda. Thanks @BrainNya for active promotion.

## 0.3.2

* Add confugurable result callback [#14][]

[#14]:https://github.com/ZeroOneStudio/rubykassa/pull/14

## 0.3.1

* Pass `controller` and `notification` variables to callback block by @1um [#12][]
* Create `@notification` for `RobokassaController#fail` by @1um [#13][]

[#12]:https://github.com/ZeroOneStudio/rubykassa/pull/12
[#13]:https://github.com/ZeroOneStudio/rubykassa/pull/13

## 0.3.0

* Add confugurable success and fail callbacks

## 0.2.6

* Fix bug with wrong signature generating with custom user params

## 0.2.5

* Fix bug with passing custom params

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
