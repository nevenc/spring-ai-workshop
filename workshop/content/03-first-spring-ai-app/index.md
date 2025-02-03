---
title: First Spring AI Application
---

#### Spring AI Starters

Spring AI leverages Spring Boot starters to configure important libraries
for connecting to various LLM models. 

Explore the `spring-ai-ollama-spring-boot-starter` in pom.xml.

```editor:select-matching-text
file: ~/spring-ai-intro/pom.xml
description: Find line where we define starter
text: "spring-ai-ollama-spring-boot-starter"
```

```
<dependency>
	<groupId>org.springframework.ai</groupId>
	<artifactId>spring-ai-ollama-spring-boot-starter</artifactId>
</dependency>
```

There are other starters you could use. Check the [list of supported chat models](https://docs.spring.io/spring-ai/reference/api/chat/comparison.html).

We have also configured the lab for possible connection to OpenAI.

```editor:select-matching-text
file: ~/spring-ai-intro/pom.xml
description: Find line where we define starter
text: "spring-ai-openai-spring-boot-starter"
```

```
<dependency>
	<groupId>org.springframework.ai</groupId>
	<artifactId>spring-ai-openai-spring-boot-starter</artifactId>
</dependency>
```

#### Spring AI Configuration

Spring AI can be configured through Spring properties in `application.yaml` file.

```editor:open-file
file: ~/spring-ai-intro/src/main/resources/application.yaml
description: Open application.yaml configuration file
line: 12
```

```
spring:
  application:
    name: spring-ai-intro
  ai:
    ollama:
        base-url: http://llama.{{< param session_namespace >}}:11434/
        chat:
          options:
            model: llama3.2
        embedding:
          options:
            model: nomic-embed-text
```

Notice, we configured the Ollama Chat model `llama3.2` and embedding model `nomic-embed-text`.

#### ChatClient API

The **ChatClient** offers a fluent API for communicating with an AI Model.
It supports both a synchronous and streaming programming model.

The **ChatClient** is created using **ChatClient.Builder** object.


```editor:select-matching-text
file: ~/spring-ai-intro/src/main/java/dev/tanzu/demo/chat/SimpleChatController.java
description: Find line in SimpleChatController
text: "builder.build()"
```

```Java
@RestController
class SimpleChatController {

    private final ChatClient chatClient;

    SimpleChatController(ChatClient.Builder builder) {
        this.chatClient = builder.build();
    }

    @GetMapping(value = "/chat/simple")
    String chat(@RequestParam(value = "query", defaultValue = "who are you") String query) {

        // Simple ChatClient API call to your LLM model
        return chatClient.prompt().user(query).call().content();

    }

}
```

Notice how easy it is to create ChatClients and send messages to your AI models.

You can read more on [ChatClient API Documentation](https://docs.spring.io/spring-ai/reference/api/chatclient.html).

#### Run the Application to Execute Simple Queries

Let's rerun the application.

```terminal:execute
command: ./mvnw spring-boot:run
session: 2
```

Here are a few sample queries to execute.
```execute
http -b localhost:8080/chat/simple?query="List all nordics countries with their capital"
```

```
Here is the list of Nordic countries and their capitals:

1. Denmark - Copenhagen
2. Finland - Helsinki
3. Iceland - Reykjavik
4. Norway - Oslo
5. Sweden - Stockholm
```

```execute
http -b localhost:8080/chat/simple?query="You are a comedian. Can you write a short poem about Stockholm?"
```

```
Here's a quick attempt:

In Stockholm, the nights are long
But the party never goes wrong
The ABBA revival's in full swing
And the Meatballs sing their funky thing

I wander down the cobblestone street
Where IKEA dreams and hipsters meet
The harbor's where the boats all play
While the hipsters sip coffee all day

In Stockholm, I've lost my phone
But found a new friend by the Stockholm Stone
It's a weird town, but it feels like home
Where the crazy parties never go unknown
```

```execute
http -b localhost:8080/chat/simple?query="You are a haiku writer. Can you write a short haiku about Stockholm? In Swedish?" 
```

```
Here is a haiku about Stockholm in Swedish:

Stockholms skarvar
Guldtimmare i mörkret
Nådens stads ljus

Translation:
The Stockholm arches
Golden trumpets in the dark
City's gentle light
```

Feel free to play with various queries. 

{{< note >}}
The responses might take a bit longer since we are running this model on a local CPU Ollama host
{{< /note >}}

#### Stop the Application

You can now stop the application in the second terminal.
```terminal:interrupt
session: 2
```

{{< note >}}
🏆 *Congratulations* 🏆

👍 You have finished the lab! 👍

Feel free to [continue with optional steps](../04-prompts) or go to [Workshop Summary](../99-workshop-summary)
{{< /note >}}
