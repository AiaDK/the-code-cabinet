# Supervised vs. Unsupervised Learning

These two paradigms differ in how they use data and what kinds of problems they aim to solve.

---

## 🧠 Supervised Learning

Supervised learning involves training a model on **labeled data**. That means each data point $X_i$ has an associated label $Y_i$. The model's task is to learn a **predictor function** `f` that maps inputs to outputs, allowing it to make predictions on new, unseen data.

**Predictor function:**

$\hat{Y} = f(X)$


Where:
- $X_i$ is the input (features)
- $Y_i$ is the predicted output (label)
- $f$ is the function learned from the training data

This setup enables the model to generalize and perform tasks such as:

- **Classification** – predicting categorical labels (e.g., spam or not spam)
- **Regression** – predicting continuous values (e.g., house prices)

**Key characteristics:**
- Requires labeled data  
- Focused on making accurate predictions  
- Performance can be evaluated using metrics like accuracy, precision, RMSE, etc.

---

## 🔍 Unsupervised Learning

Unsupervised learning deals with **unlabeled data**—there are no explicit output values provided. The goal is to explore the data and uncover hidden **patterns**, **structures**, or **groupings**.

Unlike supervised learning, it does not involve prediction but instead focuses on tasks such as:

- **Clustering** – grouping similar data points (e.g., customer segmentation)
- **Dimensionality Reduction** – simplifying data by reducing the number of variables (e.g., PCA)

**Key characteristics:**
- No labels provided  
- Focused on discovering data structure  
- Useful for exploratory analysis and pattern detection

---

Understanding when to use supervised vs. unsupervised learning is essential for choosing the right approach to your data science problem.

