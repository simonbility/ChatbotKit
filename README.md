# ChatbotKit

## Install
```
git clone "https://github.com/simonbility/ChatbotKit.git"
cd ChatbotKit
swift run
```
## Usage

for now just go to [Sources/chatbot-builder/main.swift](Sources/chatbot-builder/main.swift) and modify the file directly


## Example


```swift
let resetPassword = FlowBuilder
    .create(id: "reset_password", name: "Reset Password Flow") { f, start in
        start <- f.choice("Enter your Password and your done") { choice in
            return (
                forgot: choice
                    <- f.option("ENTER_PASSWORD")
                    <- f.exit("Enter Password-Flow"),
                done: choice
                    <- f.option("FORGOT_PASSWORD")
                    <- f.message("I have forgotten my password")
                    <- f.choice("Not to worry i just sent you an email with a reset code") { choice in
                        (
                            resend: choice <- f.option("RESEND"),
                            enter: choice <- f.option("ENTER_PASSWORD")
                        )
                }
            )
        }
    }
```

## Features
Basically a small DSL to create a graph which represents the chatbotflow

can be rendered with `graphviz`

```
brew install graphviz

swift run > graph.dot
dot graph.dot -o graph.pdf -T pdf
open ./graph.pdf
```
