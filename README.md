# Sahayak

My comrade in developing iOS applications.

### How I came up with the title

`Sahayak` in Hindi means helper/assistant -- And that is what this project is going to be. This would be my go-to framework for all of my iOS related application development.

### Why `Sahayak`?

I felt like it is good to have all the stuff that you are using across the projects under the same hood. It helps with development easier. 

> Think Twice. Code Once.

### Credits & Licenses

I would like to sincerely thank these open-source projects.

- [APIClient](https://github.com/Zhendryk/APIClient) - GPL-3.0 license

I stumbled across this project when I was exploring how other developers are creating the API layer. Zhendryk has implemented the APIRequest as a protocol, but I am using `struct` and have added my own style. I liked the way it was structured but I felt that Zhendryk's implementation was a little too big for my use-case. So, I have simplified and split most of the stuff in the network layer into its own functions.

- [PixieCacheKit](https://github.com/aumChauhan/PixieCacheKit) - MIT License

I replaced the `NetworkingUtility` implementation with `NetworkService`. Rest of it is the same.

- [MaterialTextFieldSwiftUI](https://github.com/norrisboat/MaterialTextFieldSwiftUI) - MIT License

I took whatever he could offer and have added my own flavour to it. I added a new textField type and a bunch of other customisations.

- [SwiftLogger](https://github.com/sauvikdolui/swiftlogger) - MIT License

I modified the stuff that gets printed on the debugger with this one.

- [AppLogger](https://github.com/backslash-f/applogger) - MIT License

I like his implementation. Felt like adding more stuff in the log, so tinkered it a little bit.

- [Navigator](https://github.com/uwaisalqadri/SwiftUIViewUIKitNavigation)

Used this one as such. It was perfect and is still quite underrated as to how simple this is in terms of helping us navigate between SwiftUI views.

- [JWTDecode.swift](https://github.com/auth0/JWTDecode.swift) - MIT License

Using this one as is.
