---
title: First Spring AI Application
---

#### Spring AI Starters

Spring AI leverages Spring Boot starters to configure important libraries
for connecting to various LLM models. 

Explore the `spring-ai-openai-spring-boot-starter` in pom.xml.

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

There are other starters you could use. Check the [list of supported chat models](https://docs.spring.io/spring-ai/reference/api/chat/comparison.html).

We have also configured the lab for possible connection to Ollama.

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

#### Spring AI Configuration

We have configured eveything we need to connect to OpenAI. If you are using Ollama follow the configuration.

#### Ollam Configuration (Optional)
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
        base-url: http://llama-proxy.{{< param workshop_namespace >}}:11434/
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

{{< note >}}
Please wait for the Spring application to finish in lower terminal, e.g. **Started AiApplication in ...**
{{< /note >}}

Here are a few sample queries to execute.
```execute
http -b localhost:8080/chat/simple?query="List all states of India with their capital"
```

{{< note >}}
The responses might take a bit longer since we are running this model on a local CPU Ollama host
{{< /note >}}

```
Here is the list of states in India along with their capitals:

1. Andhra Pradesh - Amaravati
2. Arunachal Pradesh - Itanagar
3. Assam - Dispur
4. Bihar - Patna
5. Chhattisgarh - Raipur
6. Goa - Panaji
7. Gujarat - Gandhinagar
8. Haryana - Chandigarh (administrative capital) and Sonipat (judicial capital)
9. Himachal Pradesh - Shimla
10. Jammu and Kashmir - Srinagar (summer capital) and Jammu (winter capital)
11. Jharkhand - Ranchi
12. Karnataka - Bengaluru
13. Kerala - Thiruvananthapuram
14. Madhya Pradesh - Bhopal
15. Maharashtra - Mumbai
16. Manipur - Imphal
17. Meghalaya - Shillong
18. Mizoram - Aizawl
19. Nagaland - Kohima
20. Odisha - Bhubaneswar
21. Punjab - Chandigarh (administrative capital)
22. Rajasthan - Jaipur
23. Sikkim - Gangtok
24. Tamil Nadu - Chennai
25. Telangana - Hyderabad
26. Tripura - Agartala
27. Uttar Pradesh - Lucknow
28. Uttarakhand - Dehradun
29. West Bengal - Kolkata

Additionally, there are 8 Union Territories in India:

1. Andaman and Nicobar Islands - Port Blair
2. Chandigarh - Chandigarh (administrative capital)
3. Dadra and Nagar Haveli and Daman and Diu - Daman
4. Delhi - New Delhi
5. Jammu and Kashmir - Srinagar (summer capital) and Jammu (winter capital)
6. Ladakh - Leh
7. Lakshadweep - Kavaratti
8. Puducherry - Puducherry
```

```execute
http -b localhost:8080/chat/simple?query="You are a comedian. Can you write a short poem about Pune, India?"
```

```
Here's a quick attempt at a humorous poem about Pune:

In Pune, the land of tech and dreams,
Where startups bloom like weird, awkward schemes.
The Sahyadri hills rise high and steep,
But the traffic's worse than your grandma's creep.

The Lavasa hill station, oh so grand,
A weekend getaway for the wealthy band.
But let's be real, it's just a bunch of flats,
With roads that wind and never take it back.

The Pune people, oh so bold and bright,
Will tell you all about their latest fight.
About the weather, or the prices too,
But they'll always laugh with you.

So if you ever find yourself in this land,
Just remember, the humor's at your hand!
For in Pune, laughter's just a tweet away,
And the jokes are made for all, every single day!
```

```execute
http -b localhost:8080/chat/simple?query="You are a haiku writer. Can you write a short haiku about Pune? In Marati?" 
```

```
Here's a haiku in Marathi:

पुण्याची रात्री (Punechya Raatri)
सूरज सेतुवर (Surasetu Var)
माणसांचा हळू (Manasach Halu)

Translation:

Pune's night
Sunrise over the bridge
People's gentle dance
```

Feel free to play with various queries. 



#### Stop the Application

You can now stop the application in the second terminal.
```terminal:interrupt
session: 2
```

{{< note >}}
🏆 *Congratulations* 🏆

👍 You have finished the lab! 👍

Feel free to [continue with optional steps](../04-prompts) or go to

[🏁 Workshop Summary 🏁](../99-workshop-summary)
{{< /note >}}
