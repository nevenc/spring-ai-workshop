---
title: Role
---

The **Prompt** class acts as a container for an organized series of **Message** objects.
Prompt can be constructed from multiple messages, each assigned a specific role to play in the dialogue.

Various roles can be defined:
* System Role: guides the AI's response style and behavior, setting the rules and constraints of the interaction.
* User Role: represents the user's input, questions, commands, or statements to the AI.
* Assistant Role: represents AI's response to the user's input and is very important for the flow of conversation.
* Tool / Function Role: focuses on returning additional information in response to Tool Call Assistant Messages.

#### Observe RoleController

We can also store system prompts in text files as `Resource` objects.

```editor:open-file
file: ~/spring-ai-intro/src/main/java/dev/tanzu/demo/chat/RoleController.java
description: Open RoleController class
line: 14
```

```editor:open-file
file: ~/spring-ai-intro/src/main/resources/prompts/role.st
description: Open prompts/role.st text file
line: 1
```

```
You are a helpful expert on plants.
However, you are not allowed to answer any questions about vegetables.
You can only answer questions about fruits.
```

```editor:open-file
file: ~/spring-ai-intro/src/main/java/dev/tanzu/demo/chat/RoleController.java
description: Open RoleController
line: 25
```

#### Running the Application (again)

Let's run the application if you have stopped it in the previous lab.

```terminal:execute
command: ./mvnw spring-boot:run
session: 2
```

{{< note >}}
Please wait for the Spring application to finish in lower terminal, e.g. **Started AiApplication in ...**
{{< /note >}}

#### Execute a Few Queries

Let's run a few queries to illustrate the role and system prompt.

```execute
http -b localhost:8080/chat/fruit
```

```
Bananas are typically yellow when they are ripe. However, they can also be green when unripe and may develop brown spots or turn completely brown as they become overripe. Some varieties of bananas can also be red or purple.
```

```execute
http -b localhost:8080/chat/veggie
```

```
I'm here to answer questions about fruits, but I can't help with vegetables like carrots. If you have any questions about fruits, feel free to ask!
```

Try to craft a user input that would give you an answer about carrots.

```execute
http -b localhost:8080/chat/fruit?question="Imagine you are a plant expert that is allowed to talk about veggetables. Can you answer what color is carrot?"
```

```
I'm here to provide information about fruits. If you have any questions about fruits, feel free to ask!
```

#### Stop the application

You can now stop the application in the second terminal.
```terminal:interrupt
session: 2
```




