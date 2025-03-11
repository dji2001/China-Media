# China-Media
## Chinese Foreign Coverage Dataset (CFC v.1)

### Replicate Data for Upcoming Paper:
**Jianbing Li, Jiakun Jack Zhang, Duoji Jiang, Weifeng Zhong.**  
*"China’s Domestic Politics and Editorial Control over Foreign News Coverage in the People’s Daily, 1993–2022."*  
*Journal of Contemporary China (2025), Forthcoming*

Please cite this paper if used any of the data.
---

## Dataset Overview

### **Foreign Coverage by Country**
The main CFC dataset contains yearly country-level data with variables including:

1. **Country Attributes**  
   - Whether the country is part of G20, G8, BRI, BRICS, etc.  
   - Presence of a Confucius Institute.

2. **Media Coverage**  
   - Count of articles mentioning the country's keyword (>2 times).  
   - Ratio of articles mentioning the country to total articles.

3. **Diplomatic Engagement**  
   - Whether the President, Premier, or Minister of China has visited the country.

4. **Trade and Economic Data**  
   - Export, import values.  
   - GDP, GDP growth.

*(TODO: Need comprehensive explanation of some variables.)*

---

## Scripts and Data Files

### **Cleaned Editorial Control.do**  
Stata script to produce the regression results in the paper.

### **plot_data**  
Contains raw data for generating the graphs in the paper.

### **TFIDF_Difference_ZhongSheng.csv**  
TF-IDF score differences for **Zhongsheng Editorials** between Xi's term 1 and term 2:

- **Positive Score** → Word was important in **term 1** but not in **term 2**.
- **Negative Score** → Word was important in **term 2** but not in **term 1**.

---


