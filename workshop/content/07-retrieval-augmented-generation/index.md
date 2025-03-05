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
file: ~/spring-ai-intro/src/main/resources/prompts/feedback.st
description: Open prompts/feedback.st
line: 1
```

Before we get to interact with the data, we need to retrieve relevant data, e.g.

```editor:select-matching-text
file: ~/spring-ai-intro/src/main/java/dev/tanzu/demo/feedback/FeedbackController.java
description: Find line where we find all entries
text: "var foundDocuments = vectorStore.similaritySearch(searchBuilder);"
```

```editor:select-matching-text
file: ~/spring-ai-intro/src/main/java/dev/tanzu/demo/feedback/FeedbackController.java
description: Find line where we concatenate all entries into context string
text: "String documents = foundDocuments"
```

```editor:select-matching-text
file: ~/spring-ai-intro/src/main/java/dev/tanzu/demo/feedback/FeedbackController.java
description: Find line where we call the model to return the question asked
text: "return chatClient"
```


#### Use the RAG to get contextual data

Let's run a query to interact with the contextual data, e.g.

```execute
http -b 'localhost:8080/feedback/chat'
```

```
Here is a random feedback from the list:

"The lab was great, but the waiting area could be improved." - Ravi Kumar
```

Feel free to experiment with other questions, e.g.

```execute
http -b 'localhost:8080/feedback/chat?question="what were postive comments on the feedback"'
```

```
Here are some of the positive comments from the feedback:

1. "Excellent lab, exceeded expectations." - Aarav Sharma
2. "Amazing facilities and helpful staff!" - Ananya Singh
3. "The lab was excellent, and the staff was very professional." - Akash Singh
4. "Outstanding service and very clean facilities." - Rajesh Khanna
5. "Amazing experience! The facilities were top-notch." - Anjali Nair
6. "Highly recommend this lab for its professionalism!" - Arjun Patel
7. "Fantastic experience! Highly recommended." - Pooja Reddy
8. "The lab exceeded my expectations. Great service!" - Vikram Patel
9. "Excellent service and knowledgeable staff!" - Priya Nair
```

{{< note >}}
🏆 *Congratulations* 🏆

👍 You have finished the lab! 👍

{{< /note >}}
