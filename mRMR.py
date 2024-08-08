import pandas as pd
from sklearn.feature_selection import mutual_info_classif
from sklearn.preprocessing import StandardScaler, LabelEncoder
from scipy.stats import pearsonr, kendalltau
from scipy.spatial.distance import pdist, squareform
data = pd.read_csv('path to dataset')
target_column = 'Target'
X = data.drop(target_column, axis=1)
y = data[target_column]
if y.dtype == 'object':
    le = LabelEncoder()
    y = le.fit_transform(y)
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)
# Maximum relevancy
mi_scores = mutual_info_classif(X_scaled, y)
pearson_scores = [abs(pearsonr(X_scaled[:, i], y)[0]) for i in range(X_scaled.shape[1])]
mr_scores = (mi_scores + pearson_scores) / 2
# Minimum Redundancy 
kendall_scores = [abs(kendalltau(X_scaled[:, i], y)[0]) for i in range(X_scaled.shape[1])]
dist_matrix = squareform(pdist(X_scaled.T, metric='euclidean'))
dist_scores = dist_matrix.mean(axis=0)
redundancy_scores = (kendall_scores + dist_scores) / 2
# mRMR Feature Selection
selected_features = []
feature_select = 1000
for _ in range(feature_select):
    best_feature = None
    best_score = float('-inf')    
    for i in range(X_scaled.shape[1]):
        if i in selected_features:
            continue
        relevance = mr_scores[i]
        redundancy = sum(redundancy_scores[j] for j in selected_features) / (len(selected_features) + 1) if selected_features else 0
        mrmr_score = relevance - redundancy        
        if mrmr_score > best_score:
            best_score = mrmr_score
            best_feature = i    
    selected_features.append(best_feature)
selected_feature_names = X.columns[selected_features]
print("Selected Features:", selected_feature_names)
X_selected = X[selected_feature_names]
X_selected.to_csv('selected_features.csv', index=False)
