# Startup Founder Valuations (Kaggle) Dataset: https://www.kaggle.com/datasets/firmai/startup-founder-valuations-dataset

# Python Notebook - Startup Founder Valuations Statistical Analysis:

startup_founder_chars = datasets["startup_founder_chars"]
startup_founder_chars

print(startup_founder_chars.head())
print(startup_founder_chars.tail())
print(startup_founder_chars.describe())
print(startup_founder_chars.info())
startup_founder_chars.isnull().sum()

startup_founder_chars_cleaned = datasets["startup_founder_chars_cleaned"]
startup_founder_chars_cleaned

print(startup_founder_chars_cleaned.head())
print(startup_founder_chars_cleaned.tail())
print(startup_founder_chars_cleaned.describe())
print(startup_founder_chars_cleaned.info())
startup_founder_chars_cleaned.isnull().sum()

startup_valuations = datasets["startup_valuations"]
startup_valuations

print(startup_valuations.head())
print(startup_valuations.tail())
print(startup_valuations.describe())
print(startup_valuations.info())
startup_valuations.isnull().sum()

startup_valuations_cleaned = datasets["startup_valuations_cleaned"]
startup_valuations_cleaned

print(startup_valuations_cleaned.head())
print(startup_valuations_cleaned.tail())
print(startup_valuations_cleaned.describe())
print(startup_valuations_cleaned.info())
startup_valuations_cleaned.isnull().sum()

from scipy.stats import ttest_ind

group_1 = datasets["seed_valuation_not_ivy_league"]
group_2 = datasets["seed_valuation_ivy_league"]

t_stat, p_val = ttest_ind(group_1, group_2)

print("t-statistic = ", t_stat)
print("p-value = ", p_val)

# H0: Ivy League Founders do not fundraise at higher seed valuations than non Ivy League Founders (no statistically significant difference in means)
# H1: Ivy League Founders do fundraise at higher seed valuations than non Ivy League Founders (statistically significant difference in means)
# Conclusion: We fail to reject the null hypothesis that Ivy League Founders do not fundraise at higher seed valuations than non Ivy League Founders
# Therefore, there is no statistically significant difference in means between the groups of founders

from scipy.stats import f_oneway

treatment_a = datasets["Arts-Related"]
treatment_b = datasets["Business-Related"]
treatment_c = datasets["Humanities-Related"]
treatment_d = datasets["STEM-Related"]

f_stat, p_val = f_oneway(treatment_a, treatment_b, treatment_c, treatment_d)

print("F-statistic = ", f_stat)
print("p-value = ", p_val)

# H0: The type of University Major a Founder comes from does not affect their ability to fundraise at higher seed valuations (no statistically significant difference in means among University Major Types)
# H1: The type of University Major a Founder comes from does affect their ability to fundraise at higher seed valuations (statistically significant difference in means among University Major Types)
# Conclusion: We fail to reject the null hypothesis that the type of University Major a Founder comes from does not affect their ability to fundraise at higher seed valuations
# Therefore, there is no statistically significant difference in means between the University Major Types
