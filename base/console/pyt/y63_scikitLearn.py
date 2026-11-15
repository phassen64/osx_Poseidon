#   ***************************************************************************
#   My Python Tutorial  ::  scikitLearn     [2026-10-27]
#   ***************************************************************************
#   coding:UTF8
#   !$@€ƒ„…†‡ˆ‰Š‹ŒŽ‘“”•—™š›œžŸ¡¢£¤¥¦§¨©«¬®°±²³µ¶·¹º»¼½¾¿ÑÖ×ØÜÞßäæçîðñôö÷üýþÿ--$

#   === :header
import sys
assert sys.version_info >= (3,9)

#   import.LIB
import LIB_inc as m;  g = m.CLib();   sTc = 'TcSciKitLearn'
g.f_header(sTc)

#   import.MOD
try:    
    # Imports Decision Tree model
    from sklearn.tree import DecisionTreeClassifier 
    
except ImportError as e:
    sEc = e.__str__()
    g.f_warning(sEc); g.f__exit(0)

#   === :content
'''
    !content:
        •   m:  scikitLearn
'''

#   m:  seaborn


#   Training data (weight in grams)
#   Input features (weights)
X = [[120], [130], [140], [180], [190], [200]] 

#   Labels
y = ["Apple", "Apple", "Apple", 
        "Orange", "Orange", "Orange"] 

# Output classes
# Create and train the model

#   Initializes model
model = DecisionTreeClassifier() 

# Trains model on data
model.fit(X, y) 

# Predict a fruit with weight 200g
# Predicts fruit type
prediction = model.predict([[200]]) 

#   Displays prediction
print("Predicted Fruit:", prediction[0]) 

#   <<< Orange

#   === :footer
g.f_footer(sTc)
