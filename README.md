# Zontik

__Zontik__ is an application that has been developed solely for the purpose of professional development.
__Zontik__ is an application that allows users to rent or buy umbrellas from nearby pick-up points.
A person with umbrellas is supposedly standing at these points and with the help of another (non-existent) application performs the procedure for providing or receiving umbrellas.

As an API, I used the ready-made API of my friend from the university, who did such a assignment.

## Installation

Use the Cocoa Pod tool to install dependency libraries.

```bash
pod install
```

## Screen Description
Zontik has 6 screens and you can find its description below:

| Name               | Description |
|--------------------|-------------|
| Main               | On the main screen, the user can see the prices for buying and renting umbrellas. Also, the user has the ability to perform one of four actions. The user can initiate a purchase or a rent, the user can look at the map with the pick up points, or can open information screen.|
| Map                | If the user opens a screen with a map, then the user can have one of two modes. Pick up locations view mode - the user enters this mode if he opened the map from the main screen, and the second mode is the rent mode, which appears after the rent has already begun. In the first mode, the user has the opportunity to initiate a rental case, return to the main screen or open information. In the second mode, the user can complete the rent or can decide to buy an umbrella and not return it. Also on this screen, the user sees how much time has passed and how much he will have to pay. In the second mode, if the user's rental reaches the maximum value, the user automatically goes to the home screen and his rental is considered completed. |
| PaymentScreen | This screen is the first link in the process of buying or renting an umbrella. On this screen, the user is shown the rules for using this service. It is also possible to open a screen with information. It is assumed that in the real service at this stage the user would need to provide their payment details.      |
| QRCodeScreen       | This screen can appear for the user in three cases. During the rental or purchase process before the umbrella is issued, or during the rental process before the umbrella is returned. The user has three options. Go back one screen, continue the process, or open the information screen. In order for the user to continue using, the QR code must be scanned by a person at the pick up point. Until this moment, the user will be shown a message with this information and the transition to the next screen will not be available. Since this application only imitates the work of the real one, the QR code cannot be scanned yet. To continue working, you need to copy the request link from the developer console and paste it into the search bar in the browser. After that, you can continue to use. |
| Feedback Screen | On this screen, the user can only enter information about his experience - a rating from 1 to 5 and a comment. Also, the user can leave all fields empty and continue using. After this screen, the user is taken to the main screen of the application. |
| Information Screen | On this screen, the user can see frequently asked questions and answers. He (or she) can also close this screen and get to the one from which it came. |

# Other Technical Information
If the application crashes at important stages, then after opening it, the user will be immediately transferred to closed screens and all the required information will be restored from local storage.
This applies to two screens - Map screen in rent mode and QRCode screen.

If the user does not have access to the Internet, he will be warned that there is no way to use the application at the moment.
