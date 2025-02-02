---
title: (Optional) Prompts
---

#### Promps and Prompt Engineering

In AI-driven applications, a **prompt** is a carefully crafted input that
instructs a language model (LLM) to generate a specific response. Prompts act
as a bridge between user intent and AI output, shaping how the model interprets
and responds to requests.

[ChatClient API](https://docs.spring.io/spring-ai/reference/api/chatclient.html)
offers great abstractions and advanced constructs via
[Advisors API](https://docs.spring.io/spring-ai/reference/api/advisors.html)
to provide additional contextual data by intercepting, modifying and
enhancing AI-driven interactions with the model.

Try to be as concise and direct as possible in crafting a great prompt for best results.

It is possible to parameterize placeholders in your prompt templates with braces `{}`.

Observe the example from the code:

```
Tell me a joke about {topic}.
Respond in {language} language.
```

Read more about advanced prompt techniques in [Spring AI Documentation]
(https://docs.spring.io/spring-ai/reference/api/prompt.html)

#### Observe PromptChatController

We can also store prompts in text files as `Resource` objects, e.g.

```editor:open-file
file: ~/spring-ai-intro/src/main/java/dev/tanzu/demo/chat/PromptChatController.java
description: Open PromptChatController
line: 13
```

```editor:open-file
file: ~/spring-ai-intro/src/main/resources/prompts/joke.st
description: Open prompts/joke.st text file
line: 1
```

We are passing two parameters: 
* `topic` with default **food** topic
* `lang` with default **English** language

```editor:open-file
file: ~/spring-ai-intro/src/main/java/dev/tanzu/demo/chat/PromptChatController.java
description: Open PromptChatController
line: 22
```

#### Run the application (again)

Let's run the application if you have stopped it in the previous lab, e.g.

```terminal:execute
command: ./mvnw spring-boot:run
session: 2
```

#### Execute simple queries

Let's run few queries, e.g.

```execute
http localhost:8080/chat/joke
```

```
Why was the pizza in a bad mood?
Because it was feeling crusty! (get it?)
```

```execute
http 'localhost:8080/chat/joke?topic=Stockholm&lang=Swedish'
```

```
Varför gick maffian till Stockholm? Något med "bok och stek" såg ut att funka bra.

Translation:
Why did the mafia go to Stockholm? Something with "book and steak" seemed to work well.

Note: The joke relies on a play on words, where "bok" means book but also sounds like "bokstävel", which is an old-fashioned term for a gangster or a thug.
```

Feel free to play with various queries.

#### Stop the application

You can stop the application in the second terminal:

```terminal:interrupt
session: 2
```
