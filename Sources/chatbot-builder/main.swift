import ChatbotKit

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

let login = FlowBuilder
    .create(id: "login", name: "Login User") { f, start in
        start <- f.choice("CHOICE LOGIN") { choice in
                return (
                    email: choice
                        <- f.option("Email?"),

                    done: choice
                        <- f.option("Enter Password")
                        <- f.message("Enter")
                        <- f.exit("Done")
                )
        }
    }



print(resetPassword.render())
