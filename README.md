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

#### Output

```
digraph G {
  reset_password_choice_1[label="Enter your Password and your done"];
  reset_password_choice_2[label="Not to worry i just sent you an email with a reset code"];
  reset_password_entry_1[label="Reset Password Flow"];
  reset_password_exit_1[label="Enter Password-Flow"];
  reset_password_message_1[label="I have forgotten my password"];
  reset_password_option_1[label="ENTER_PASSWORD"];
  reset_password_option_2[label="FORGOT_PASSWORD"];
  reset_password_option_3[label="RESEND"];
  reset_password_option_4[label="ENTER_PASSWORD"];

  reset_password_choice_1 -> reset_password_option_1
  reset_password_choice_1 -> reset_password_option_2
  reset_password_choice_2 -> reset_password_option_3
  reset_password_choice_2 -> reset_password_option_4
  reset_password_entry_1 -> reset_password_choice_1
  reset_password_message_1 -> reset_password_choice_2
  reset_password_option_1 -> reset_password_exit_1
  reset_password_option_2 -> reset_password_message_1
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
