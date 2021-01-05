import Cocoa
import CreateML

let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/user183479/Library/Mobile Documents/com~apple~CloudDocs/OS 13 & Swift 5 - Bootcamp/Assets/S26-NLP/twitter-sanders-apple3.csv")) // try is  not catched so the app will fail and the code will not continue and that's what we want

let (trainingData, testingData) = data.randomSplit(by: 0.8, seed: 5)  // return tuple  // seed relates to how random number generators work. Random number generation using a computer is never truly random in the same way that it's random in nature. Now, in certain instances, if you want to be able to reproduce the randomness from a random number generator, you can use something called a seed. So, for example, we're currently splitting our data randomly to 80 percent and 20 percent.But if we need to reproduce this in the future to, say, debug our code or try to figure out why is it that our model isn't working, then we can use the same seed to generate the same randomSplit. So in here, I'm just going to put 5, and in the future if I need my data to be split randomly in exactly the same way, then I can simply use that 5 as the seed to achieve that

let sentimentClassifier =  try MLTextClassifier(trainingData: trainingData, textColumn: "text", labelColumn: "class")   // machine learning model   // text and label column names in .csv

let evaluationMetrics = sentimentClassifier.evaluation(on: testingData, textColumn: "text", labelColumn: "class")

let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError) * 100

let metdata = MLModelMetadata(author: "Rami Abdel Majid", shortDescription: "A model trained to classify sentiment on Tweets", version: "1.0")

// save model
try sentimentClassifier.write(to: URL(fileURLWithPath: "/Users/user183479/Library/Mobile Documents/com~apple~CloudDocs/OS 13 & Swift 5 - Bootcamp/Assets/S26-NLP/TweetSentimentClassifer.mlmodel"), metadata: metdata)

// test our model prediction
try sentimentClassifier.prediction(from: "@Apple is a terrible company!")

try sentimentClassifier.prediction(from: "I just found the best restaurent ever, and it's @DuckandWaffle")

try sentimentClassifier.prediction(from: "I think @CocaCola ads are just ok.")
