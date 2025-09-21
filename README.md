# Data Science & Data Analysis Portfolio

##  About

Hi, I'm Deep Shah. I have an academic background in Automobile Engineering and completed my MBA in General Management. I began my career in sales, which gave me a strong understanding of business operations. Over time, I transitioned into a data analyst role, where I have been working for the past year, applying analytical techniques to support business decisions.

I have a solid foundation in Machine learning, Deep learning, Statistical analysis and Data visualization. I am skilled in Python, SQL, Tableau, Power BI, and Excel, with experience in cleaning, analyzing, and interpreting complex datasets to uncover meaningful insights. I have also completed a certification in Artificial Intelligence and Machine Learning to strengthen my technical foundation.

I’m passionate about using data science to solve real-world problems and optimize operational efficiency. I’m currently looking to grow further in the field of data analysis or data science, continuously learning and applying my skills to create business impact.

My CV in [pdf](./Deep%20Shah_Resume.pdf)

---

##  Portfolio Projects
This section highlights my data analytics projects, each briefly describing the problem solved and the technology stack used.

### Python
###  House Price Prediction

- **[House Price Prediction](House%20Price%20Prediction/House_Price_Prediction.ipynb)**  
  This project focuses on predicting house prices using supervised machine learning techniques. The workflow includes data cleaning, exploratory data analysis (EDA), and applying multiple regression models to evaluate performance and accuracy.

  **Models Used:**
  - Linear Regression  
  - Support Vector Regression (SVR)  
  - Random Forest Regressor  
  - XGBoost Regressor  

  **Key Steps Involved:**
  - Handling missing values and encoding categorical features  
  - Conducting EDA to understand relationships and distributions  
  - Implementing cross-validation and hyperparameter tuning for model optimization  
  - Evaluating models using RMSE, MAE, and R² Score  
  - Visualizing feature importance to interpret model results (for tree-based models)  

  **Tools & Libraries:**  
  Python, Pandas, NumPy, Scikit-learn, XGBoost, Matplotlib, Seaborn

### Walmart Sales Forecasting

- **[Walmart Sales Forecasting](Walmart%20Sales%20Forecast/Walmart_Sales_Forecast.ipynb)**  
 This project aims to forecast Walmart's weekly sales using a structured machine learning pipeline. It covers data preprocessing, feature engineering, exploratory data analysis (EDA), and model training and   evaluation using both classical and advanced regression algorithms.

  **Models Used:**
  - Linear Regression
  - Lasso Regression
  - Ridge Regression
  - Random Forest Regressor  
  - XGBoost Regressor  

  **Key Steps Involved:**
  - Merging and cleaning multiple datasets
  - Handling missing values and encoding categorical features
  - Exploratory Data Analysis (EDA) to uncover patterns
  - Model optimization using cross-validation and hyperparameter tuning
  - Evaluation using RMSE, MAE, and R² Score
  - Visualizing feature importance (for tree-based models)

  **Tools & Libraries:**  
   Python, Pandas, NumPy, Matplotlib, Seaborn, Scikit-learn, XGBoost, TensorFlow/Keras (for deep learning models), Google Colab (GPU environment)

  **Future Work:**
  - Implement LSTM-based models for time-series prediction
  - Incorporate additional seasonality and promotional features
  - Deploy model using Streamlit or Flask for real-time inference

### Historical Structures Image Classification

- **[Historical_structures_classification](historical_structures_classification.ipynb)**  
 This project focuses on classifying images of historical architectural structures into **11 categories** using **Transfer Learning** with TensorFlow/Keras. It includes data preprocessing, model building with pretrained CNN backbones, training, evaluation, and visualization of results.  

  **Models Used**  
  - ResNet50 (ImageNet pretrained, frozen base)  
  - EfficientNetB0 (ImageNet pretrained, frozen base)
  
  **Key Steps Involved**  
  - Loading and preprocessing images from directory structure  
  - Splitting training data into training & validation sets  
  - Resizing, batching, and optimizing datasets with prefetching  
  - Building custom classification heads on top of pretrained models  
  - Training models and monitoring accuracy/loss curves  
  - Evaluating performance on test set  
  - Generating and visualizing confusion matrices

  **Tools & Libraries**  
  - Python, NumPy, Pandas, TensorFlow/Keras, Matplotlib, Seaborn, Scikit-learn 

  **Future Work**  
  - Fine-tuning base models for improved accuracy  
  - Experimenting with other architectures (e.g., EfficientNetV2, InceptionV3)  
  - Data augmentation for better generalization  
  - Deployment using Streamlit or Flask for interactive classification  

### Online Retail Customer Segmentation

- **[Online Retail Customer Segmentation](Online_Retail_Customer_Segmentation.ipynb)**
 This project focuses on segmenting retail customers using **RFM (Recency, Frequency, Monetary)** analysis and clustering techniques. The workflow includes data cleaning, exploratory data analysis (EDA), feature engineering, and applying clustering algorithms to group customers based on purchasing behavior.

**Techniques & Models Used**
- RFM Analysis (Recency, Frequency, Monetary metrics)  
- K-Means Clustering  
- Elbow Method & Silhouette Score for optimal cluster selection

**Key Steps Involved**
- Handling missing values and removing invalid transactions (negative quantities, missing customer IDs)  
- Feature engineering: creating `Amount` and RFM metrics  
- Conducting EDA to analyze distributions and customer patterns  
- Standardizing data before clustering  
- Applying K-Means clustering to segment customers  
- Interpreting clusters and labeling groups (e.g., Champions, At Risk, Loyal Customers, etc.)  

**Evaluation & Insights**
- Used Elbow Method and Silhouette Score to determine the optimal number of clusters  
- Segments interpreted to guide marketing strategies and retention plans  
- Visualization of customer segments on Recency, Frequency, and Monetary dimensions  

**Tools & Libraries**
- Python, Pandas, NumPy, Scikit-learn, Matplotlib, Seaborn
   
---

### SQL

 ###  Olympic Games Analysis – SQL Project
- **[Olympics Data Exploration](Olympic%20Games%20Analysis/Olympic_Analysis.sql)**  

This project involves analyzing Olympic Games data using structured SQL queries. The analysis covers various dimensions of the Olympics dataset such as participation, medal tallies, athlete performance, and country-wise success.


####  SQL Techniques used:
- Data aggregation and filtering
- Window functions (`RANK()`, `DENSE_RANK()`, `OVER()`)
- Common Table Expressions (CTEs)
- String concatenation and conditional logic
- Grouping and sorting for insightful breakdowns

> This analysis demonstrates the use of SQL for deriving insights from a sports dataset, useful for exploring historical trends, nation-wise performance, and medal distributions.

***
### Bike Store Sales Analysis – SQL Project

- **[Bike Store SQL Analysis](Bike%20Store%20Analysis/Bike_Stores_Analysis.sql)**  

This project involves performing a detailed sales analysis for a bike store using structured SQL queries. It explores various business-critical metrics such as product performance, customer trends, sales distribution across stores and cities, and staff efficiency.


#### SQL Techniques Used

- Data aggregation with `SUM()`, `COUNT()`, `ROUND()`, and `CAST()`
- Ranking and window functions (`RANK() OVER`)
- Date/time extraction using `strftime()` for year-wise trends
- Conditional logic with `CASE WHEN`
- Joins across multiple related tables (customers, products, orders, stores, etc.)
- Subqueries and nested aggregations

> This analysis highlights how SQL can be effectively used to evaluate retail sales performance, understand customer behavior, monitor inventory flow, and identify high-performing regions, products, and staff.


---
### Power BI

### Bike Store Analysis

This Power BI dashboard analyze the performance of a fictional bike store business across multiple dimensions including revenue, quantity sold, product categories, brands, stores, and states.

![Bike Store Dashboard](Bike%20Store%20Analysis/Bike_Store_Dashboard.png) 

## Dashboard Highlights

- Total Revenue (2016–2018)
- Revenue by category, brand, and store
- Quantity sold by product category and state
- Top brands: Trek, Electra, Surly
- Product count by brand
- Brand-wise filtering via slicer for detailed insights

[Download the interactive Power BI report (.pbix)](Bike%20Store%20Analysis/Bike_Store_Analysis.pbix) for detailed exploration.
