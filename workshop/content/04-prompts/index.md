---
title: Prompts
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

Try to be as concise and direct as possible in crafting an excellent prompt for the best results.

It is possible to parameterize placeholders in your prompt templates with braces `{}`.

Observe the example from the code:

```
Tell me a joke about {topic}.
Respond in {language} language.
```

Read more about advanced prompt techniques in [Spring AI Documentation]
(https://docs.spring.io/spring-ai/reference/api/prompt.html)

#### Observe PromptChatController

We can also store prompts in text files as `Resource` objects.

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

Let's run the application if you have stopped it in the previous lab.

```terminal:execute
command: ./mvnw clean spring-boot:run
session: 2
```

{{< note >}}
Please wait for the Spring application to finish in lower terminal, e.g. **Started AiApplication in ...**
{{< /note >}}

#### Execute simple queries

Let's run a few queries.

```execute
http -b localhost:8080/chat/joke
```

```
Why was the pizza in a bad mood?
Because it was feeling crusty! (get it?)
```

```execute
http -b 'localhost:8080/chat/joke?topic=Pune&lang=Marati'
```

```
पुणेकरांचं स्वभावच असं असतं की, "आम्ही पुण्याचे आहोत" हे सांगायला त्यांना पाच सेकंद लागतात, पण "पुणं हे महाराष्ट्रात आहे" हे सांगायला पाच मिनिटं लागतात!

Translation:
It’s just the nature of Punekars (residents of Pune) that it takes them five seconds to say, ‘We are from Pune,’ but it takes them five minutes to say, ‘Pune is in Maharashtra!’”
```

Feel free to play with various queries.

#### Stop the Application

You can now stop the application in the second terminal.

```terminal:interrupt
session: 2
```