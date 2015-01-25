#Code Book#

##Data source##

The title of the original dataset is "Human Activity Recognition Using Smartphones Data Set." The dataset was originally availabel here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##Variable Descriptions##

The original dataset contained the following variables

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

For the purposes of this assignment, I selected only the variables that represented the mean and the standard deviation. 


##Data Transformations##

The original dataset was modified from 563 variables to 88 variables that were selected based on the instructions of the project. The variables were mean and standard deviation. The next step of the process was to clean up the variable names. The variable names were adjusted to exclude all special characters and spaces. Also, in the traintype column, activity codes were replaced with activity descriptions. For example, number 5 was replaced with 'SITTING'. 


##Final Dataset##

The final dataset contains 180 observations and 88 variables, which represents average mean and standard deviations for each activity and each subjetc. 

