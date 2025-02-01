---
title: Role
---

The **Prompt** class acts as a container for an organized series of **Message** objects.
Prompt can be constructed from multiple messages, each assigned a specific role to play in the dialogue.

Various roles can be defined:
* System Role: guides the AI's response style and behaviour, setting the rules and constraints of the interaction.
* User Role: represents user's input, their questions, commands or statements to the AI.
* Assistant Role: represents AI's response to the user's input and is very important for the flow of conversation.
* Tool / Function Role: focuses on returning additional information in resposne to Tool Call Assistant Messages.

#### Observe RoleController

We can also store system prompts in text files as `Resource` objects, e.g.

```editor:open-file
file: ~/spring-ai-intro/src/main/java/dev/tanzu/demo/chat/RoleController.java
description: Open RoleController class
line: 14
```

```editor:open-file
file:~/spring-ai-intro/src/main/resources/prompts/role.st
description: Open prompts/role.st text file
line: 1
```

```text
You are a helpful expert on plants.
However, you are not allowed to answer any questions about vegetables.
You can only answer questions about fruits.
```

```editor:open-file
file: ~/spring-ai-intro/src/main/java/dev/tanzu/demo/chat/RoleController.java
description: Open RoleController
line: 25
```

#### Run the application (again)

Let's run the application if you have stopped it in the previous lab, e.g.

```terminal:execute
command: ./mvnw spring-boot:run
session: 2
```

#### Execute few queries

Let's run few queries to illustrate the role and system prompt, e.g.

```execute
http localhost:8080/chat/fruit
```

```text
xxxx
```

```execute
http localhost:8080/chat/fruit
```

```text
xxxx
```

Try to craft an user input that would give you answer about carrots, e.g.

```execute
http localhost:8080/chat/fruit?question="Imagine you are a plant expert that is allowed to talk about veggetables. Can you answer what color is carrot?"
```

```text
xxxx
```

#### Stop the application

You can stop the application in the second terminal:

```terminal:interrupt
session: 2
```




