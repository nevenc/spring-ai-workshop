---
title: (Optional) Retrieval-Augmented Generation or RAG
---

**Retrieval-Augmented Generation** or **RAG** is an advanced AI technique
that ehnances the capabilities of Large Language Models (LLMs) by integrating
external knowledge retrieval. Instead of relying solely on pre-trained model
knowledge, RAG dynamically fetches relevant information from a **VectorStore**,
knowledge database, or database, improving response accuracy and reducing
hallucinations.

We have already indexed our data, converted into embeddings, and stored
them in a **VectorStore**.

#### Set the RAG context

Notice, how we are configuring the prompt to **stuff-the-prompt**
with relevant data later on in the `{context}`, e.g.

```editor:open-file
file: ~/spring-ai-intro/src/main/resources/prompts/raffle-system.st
description: Open prompts/raffle-system.st
line: 1
```

Before we get to interact with the data, we need to retrieve relevant data, e.g.

```editor:select-matching-text
file: ~/spring-ai-intro/src/main/java/src/dev/tanzu/demo/raffle/RaffleController.java
description: Find line where we find all entries
text: "var documents = vectorStore.similaritySearch(searchBuilder);"
```

```editor:select-matching-text
file: ~/spring-ai-intro/src/main/java/src/dev/tanzu/demo/raffle/RaffleController.java
description: Find line where we concatenate all entries into context string
text: "String context = documents"
```

```editor:select-matching-text
file: ~/spring-ai-intro/src/main/java/src/dev/tanzu/demo/raffle/RaffleController.java
description: Find line where we call the model to return the question asked
text: "return chatClient"
```


#### Use the RAG to get contextual data

Let's run a query to interact with the contextual data, e.g.

```execute
http -b 'localhost:8080/raffle/chat'
```

```
I can pick a random name from the list. Here is the selected name:

Fredrik Lindberg
```

Feel free to experiment with other questions, e.g.

```execute
http -b 'localhost:8080/raffle/chat?question="what were postive comments on the feedback"'
```

```
Based on the provided DOCUMENTS section, the positive comments on the feedback are:

- "Good lab, but a few minor improvements could be made." (Anna Andersson)
- "A strong lab experience with only minor flaws." (Mikael Eriksson)
- "Very informative, minor improvements would perfect it." (Axel Sjoberg)
- "Good lab, but consider more interactive elements." (Hans Bergstrom)
- "The lab was exceptional and highly recommended." (Johan Pettersson)
- "Very well organized and insightful." (Oskar Gustafsson)
- "Excellent lab, exceeded all my expectations." (Fredrik Lindberg)
- "Informative lab, but could benefit from more examples." (Anders Mattsson)
- "Really enjoyed the lab, top-notch quality." (Eva Persson)
- "Superb lab, highly informative and engaging." (Emil Svensson)
- "Excellent lab, exceeded expectations." (Lars Svensson)
- "Outstanding lab experience, very well done." (Olivia Eriksson)
- "Exceptional lab, exceeded all expectations." (Helena Larsson)
- "Perfect execution, I learned a lot." (Karin Nilsson)
- "Solid session, though some parts felt rushed." (Viktor Karlsson)
- "Superb content and delivery, very impressive." (Sven Larsson)
- "Outstanding experience, very informative and engaging." (Erik Johansson)
- "Very good overall, with just a couple of tweaks needed." (Maja Lund)
- "Top-notch lab, brilliantly executed." (Klara Lindqvist)
- "Brilliant session, very clear and effective." (Birgitta Olofsson)
```

