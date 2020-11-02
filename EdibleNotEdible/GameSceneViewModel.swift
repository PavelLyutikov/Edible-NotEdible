//
//  GameSceneViewModel.swift
//  EdibleNotEdible
//
//  Created by mac on 02.05.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

var playVolume: Bool = true



class GameSceneViewModel {
    
    var currentNode: ObjectModel? = nil
    var score: Int = 0
    
    var fail: Int = 0
    
    var updateTimeLabel: () -> Void = {}
    var timer: Timer?
    var initialSeconds: TimeInterval = 15
    var gameOver: () -> Void = {}
    
    let edible = UserDefaults.standard.bool(forKey: "Edible")
    let hotCold = UserDefaults.standard.bool(forKey: "HotCold")
    let softHard = UserDefaults.standard.bool(forKey: "SoftHard")
    let carnHerb = UserDefaults.standard.bool(forKey: "CarnHerb")
    
    let bestScoreEdible = UserDefaults.standard.integer(forKey: "bestScoreEdible")
    let bestScoreHotCold = UserDefaults.standard.integer(forKey: "bestScoreHotCold")
    let bestScoreSoftHard = UserDefaults.standard.integer(forKey: "bestScoreSoftHard")
    let bestScoreCarnHarb = UserDefaults.standard.integer(forKey: "bestScoreCarnHarb")
    
    @objc func timerAction() {
        
        initialSeconds -= 0.1
            print(initialSeconds)
        
        if initialSeconds <= 0 {
            
            self.setBestScore()
            self.setScore()
            self.gameOver()
            self.timer?.invalidate()
            
      }
      updateTimeLabel()
    }
    
    init() {

        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
//    func changeFailScore(add: Bool, completion: @escaping (() -> Void) = {}) {
//        if add {
//
//            fail += 1
//
//            if fail >= 2 {
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "presentInterstitial"), object: nil)
//            }
//        } else {
//            completion()
//            print("fail")
//        }
//    }
    
    func changeScore(add: Bool, completion: @escaping (() -> Void) = {}) {
            if add {
                score += 1
                
                if score >= 50 {
                    initialSeconds = 1
                } else if score >= 25 {
                    initialSeconds = 2
                } else if score >= 20 {
                    initialSeconds = 3
                } else if score >= 15 {
                    initialSeconds = 4
                } else if score >= 10 {
                    initialSeconds = 5
                } else if score >= 5 {
                    initialSeconds = 6
                } else if score >= 1 {
                    initialSeconds = 10
                } else {
                    initialSeconds = 15
    }
            } else {
                
                self.timer?.invalidate()
                setScore()
                setBestScore()
                completion()
                
            }
        }
    
    // Вывод BestScore если побил рекорд
    func setBestScore() {
        if edible == true {
            if bestScoreEdible < score {
                UserDefaults.standard.set(score, forKey: "bestScoreEdible")
                UserDefaults.standard.synchronize()
            }
        } else if hotCold == true {
            if bestScoreHotCold < score {
                UserDefaults.standard.set(score, forKey: "bestScoreHotCold")
                UserDefaults.standard.synchronize()
            }
        } else if softHard == true {
            if bestScoreSoftHard < score {
                UserDefaults.standard.set(score, forKey: "bestScoreSoftHard")
                UserDefaults.standard.synchronize()
            }
        } else if carnHerb == true {
            if bestScoreCarnHarb < score {
                UserDefaults.standard.set(score, forKey: "bestScoreCarnHarb")
                UserDefaults.standard.synchronize()
            }
        }
        
    }
    func setScore() {
        if score >= 0 {
            UserDefaults.standard.set(score, forKey: "failedScore")
            UserDefaults.standard.synchronize()
        }
    }
    
    // ObjectModel
    let objectsArray: [ObjectModel] = [ObjectModel(name: "potato", isEdible: true),
    ObjectModel(name: "apple", isEdible: true),
    ObjectModel(name: "asparagus", isEdible: true),
    ObjectModel(name: "aubergine", isEdible: true),
    ObjectModel(name: "avocado", isEdible: true),
    ObjectModel(name: "bacon", isEdible: true),
    ObjectModel(name: "banana", isEdible: true),
    ObjectModel(name: "barbecue", isEdible: true),
    ObjectModel(name: "beans", isEdible: true),
    ObjectModel(name: "beer", isEdible: true),
    ObjectModel(name: "biscuit", isEdible: true),
    ObjectModel(name: "blackcurrant", isEdible: true),
    ObjectModel(name: "blueberry", isEdible: true),
    ObjectModel(name: "bread", isEdible: true),
    ObjectModel(name: "bread2", isEdible: true),
    ObjectModel(name: "bread3", isEdible: true),
    ObjectModel(name: "bread4", isEdible: true),
    ObjectModel(name: "bread5", isEdible: true),
    ObjectModel(name: "bread6", isEdible: true),
    ObjectModel(name: "bread7", isEdible: true),
    ObjectModel(name: "bread8", isEdible: true),
    ObjectModel(name: "broccoli", isEdible: true),
    ObjectModel(name: "broccoli2", isEdible: true),
    ObjectModel(name: "burger", isEdible: true),
    ObjectModel(name: "cabbage", isEdible: true),
    ObjectModel(name: "cake", isEdible: true),
    ObjectModel(name: "cake2", isEdible: true),
    ObjectModel(name: "can", isEdible: true),
    ObjectModel(name: "candy", isEdible: true),
    ObjectModel(name: "candy2", isEdible: true),
    ObjectModel(name: "candy3", isEdible: true),
    ObjectModel(name: "carrot", isEdible: true),
    ObjectModel(name: "cauliflower", isEdible: true),
    ObjectModel(name: "caviar", isEdible: true),
    ObjectModel(name: "cheese", isEdible: true),
    ObjectModel(name: "cheese2", isEdible: true),
    ObjectModel(name: "cherries", isEdible: true),
    ObjectModel(name: "cherries2", isEdible: true),
    ObjectModel(name: "chicken", isEdible: true),
    ObjectModel(name: "chicken2", isEdible: true),
    ObjectModel(name: "chicken3", isEdible: true),
    ObjectModel(name: "chicken4", isEdible: true),
    ObjectModel(name: "chicken5", isEdible: true),
    ObjectModel(name: "chili", isEdible: true),
    ObjectModel(name: "chips", isEdible: true),
    ObjectModel(name: "chives", isEdible: true),
    ObjectModel(name: "chocolate-roll", isEdible: true),
    ObjectModel(name: "chocolate", isEdible: true),
    ObjectModel(name: "chocolate2", isEdible: true),
    ObjectModel(name: "cinnamon", isEdible: true),
    ObjectModel(name: "coconut", isEdible: true),
    ObjectModel(name: "coconut2", isEdible: true),
    ObjectModel(name: "coffee", isEdible: true),
    ObjectModel(name: "coffee2", isEdible: true),
    ObjectModel(name: "coke", isEdible: true),
    ObjectModel(name: "cookie", isEdible: true),
    ObjectModel(name: "cookie2", isEdible: true),
    ObjectModel(name: "corn", isEdible: true),
    ObjectModel(name: "crab", isEdible: true),
    ObjectModel(name: "cranberry", isEdible: true),
    ObjectModel(name: "croissant", isEdible: true),
    ObjectModel(name: "cucumber", isEdible: true),
    ObjectModel(name: "dessert", isEdible: true),
    ObjectModel(name: "dessert2", isEdible: true),
    ObjectModel(name: "dessert3", isEdible: true),
    ObjectModel(name: "dessert5", isEdible: true),
    ObjectModel(name: "doughnut", isEdible: true),
    ObjectModel(name: "doughnut2", isEdible: true),
    ObjectModel(name: "dumpling", isEdible: true),
    ObjectModel(name: "egg", isEdible: true),
    ObjectModel(name: "egg2", isEdible: true),
    ObjectModel(name: "fish", isEdible: true),
    ObjectModel(name: "fish2", isEdible: true),
    ObjectModel(name: "fish3", isEdible: true),
    ObjectModel(name: "frappe", isEdible: true),
    ObjectModel(name: "frappe2", isEdible: true),
    ObjectModel(name: "garlic", isEdible: true),
    ObjectModel(name: "glass", isEdible: true),
    ObjectModel(name: "glass2", isEdible: true),
    ObjectModel(name: "grapes", isEdible: true),
    ObjectModel(name: "honey", isEdible: true),
    ObjectModel(name: "hot-dog", isEdible: true),
    ObjectModel(name: "ice-cream", isEdible: true),
    ObjectModel(name: "ice-cream2", isEdible: true),
    ObjectModel(name: "ice-cream3", isEdible: true),
    ObjectModel(name: "ice-cream4", isEdible: true),
    ObjectModel(name: "ice-cream5", isEdible: true),
    ObjectModel(name: "ice-cream6", isEdible: true),
    ObjectModel(name: "ice-cream7", isEdible: true),
    ObjectModel(name: "ice-cream8", isEdible: true),
    ObjectModel(name: "ice-cream9", isEdible: true),
    ObjectModel(name: "jam", isEdible: true),
    ObjectModel(name: "jam2", isEdible: true),
    ObjectModel(name: "jam3", isEdible: true),
    ObjectModel(name: "jawbreaker", isEdible: true),
    ObjectModel(name: "kebab", isEdible: true),
    ObjectModel(name: "lemon", isEdible: true),
    ObjectModel(name: "lemonade", isEdible: true),
    ObjectModel(name: "lettuce", isEdible: true),
    ObjectModel(name: "lobster", isEdible: true),
    ObjectModel(name: "lollipop", isEdible: true),
    ObjectModel(name: "meat", isEdible: true),
    ObjectModel(name: "meat2", isEdible: true),
    ObjectModel(name: "meat3", isEdible: true),
    ObjectModel(name: "melon", isEdible: true),
    ObjectModel(name: "milk", isEdible: true),
    ObjectModel(name: "milkshake", isEdible: true),
    ObjectModel(name: "mushroom", isEdible: true),
    ObjectModel(name: "noodles", isEdible: true),
    ObjectModel(name: "noodles2", isEdible: true),
    ObjectModel(name: "nut", isEdible: true),
    ObjectModel(name: "nut2", isEdible: true),
    ObjectModel(name: "nut3", isEdible: true),
    ObjectModel(name: "nut4", isEdible: true),
    ObjectModel(name: "octopus", isEdible: true),
    ObjectModel(name: "olives", isEdible: true),
    ObjectModel(name: "onigiri", isEdible: true),
    ObjectModel(name: "onigiri2", isEdible: true),
    ObjectModel(name: "onion", isEdible: true),
    ObjectModel(name: "orange", isEdible: true),
    ObjectModel(name: "pancakes", isEdible: true),
    ObjectModel(name: "pancakes2", isEdible: true),
    ObjectModel(name: "pancakes3", isEdible: true),
    ObjectModel(name: "pastry", isEdible: true),
    ObjectModel(name: "peach", isEdible: true),
    ObjectModel(name: "pear", isEdible: true),
    ObjectModel(name: "pepper", isEdible: true),
    ObjectModel(name: "pie", isEdible: true),
    ObjectModel(name: "pie2", isEdible: true),
    ObjectModel(name: "pie3", isEdible: true),
    ObjectModel(name: "pineapple", isEdible: true),
    ObjectModel(name: "pint", isEdible: true),
    ObjectModel(name: "pistachio", isEdible: true),
    ObjectModel(name: "pizza", isEdible: true),
    ObjectModel(name: "pizza2", isEdible: true),
    ObjectModel(name: "plum", isEdible: true),
    ObjectModel(name: "potato", isEdible: true),
    ObjectModel(name: "potato2", isEdible: true),
    ObjectModel(name: "potato3", isEdible: true),
    ObjectModel(name: "pudding", isEdible: true),
    ObjectModel(name: "pumpkin", isEdible: true),
    ObjectModel(name: "radish", isEdible: true),
    ObjectModel(name: "raspberry", isEdible: true),
    ObjectModel(name: "rice", isEdible: true),
    ObjectModel(name: "rice2", isEdible: true),
    ObjectModel(name: "salad", isEdible: true),
    ObjectModel(name: "sausage", isEdible: true),
    ObjectModel(name: "sausage2", isEdible: true),
    ObjectModel(name: "sausage3", isEdible: true),
    ObjectModel(name: "seeds", isEdible: true),
    ObjectModel(name: "shrimp", isEdible: true),
    ObjectModel(name: "steak", isEdible: true),
    ObjectModel(name: "steak2", isEdible: true),
    ObjectModel(name: "steak3", isEdible: true),
    ObjectModel(name: "strawberry", isEdible: true),
    ObjectModel(name: "sushi", isEdible: true),
    ObjectModel(name: "sushi2", isEdible: true),
    ObjectModel(name: "sushi3", isEdible: true),
    ObjectModel(name: "taco", isEdible: true),
    ObjectModel(name: "tea", isEdible: true),
    ObjectModel(name: "tomato", isEdible: true),
    ObjectModel(name: "water", isEdible: true),
    ObjectModel(name: "watermelon", isEdible: true),
    ObjectModel(name: "anchor", isEdible: false),
    ObjectModel(name: "anvil", isEdible: false),
    ObjectModel(name: "axe", isEdible: false),
    ObjectModel(name: "axe2", isEdible: false),
    ObjectModel(name: "axe3", isEdible: false),
    ObjectModel(name: "axe4", isEdible: false),
    ObjectModel(name: "axe5", isEdible: false),
    ObjectModel(name: "balalaika", isEdible: false),
    ObjectModel(name: "ball", isEdible: false),
    ObjectModel(name: "ball2", isEdible: false),
    ObjectModel(name: "ball3", isEdible: false),
    ObjectModel(name: "ball4", isEdible: false),
    ObjectModel(name: "ball5", isEdible: false),
    ObjectModel(name: "ball6", isEdible: false),
    ObjectModel(name: "barrel", isEdible: false),
    ObjectModel(name: "barrel2", isEdible: false),
    ObjectModel(name: "bat", isEdible: true),
    ObjectModel(name: "bat2", isEdible: false),
    ObjectModel(name: "bathroom", isEdible: false),
    ObjectModel(name: "baton", isEdible: false),
    ObjectModel(name: "beach", isEdible: false),
    ObjectModel(name: "beauty", isEdible: false),
    ObjectModel(name: "bee", isEdible: false),
    ObjectModel(name: "beetle", isEdible: true),
    ObjectModel(name: "bike", isEdible: false),
    ObjectModel(name: "bomb", isEdible: false),
    ObjectModel(name: "bomb2", isEdible: false),
    ObjectModel(name: "bomb3", isEdible: false),
    ObjectModel(name: "bomb4", isEdible: false),
    ObjectModel(name: "bomb5", isEdible: false),
    ObjectModel(name: "bomb6", isEdible: false),
    ObjectModel(name: "brush", isEdible: false),
    ObjectModel(name: "bullet", isEdible: false),
    ObjectModel(name: "cactus", isEdible: false),
    ObjectModel(name: "cannon", isEdible: false),
    ObjectModel(name: "cat", isEdible: false),
    ObjectModel(name: "cat2", isEdible: false),
    ObjectModel(name: "cauldron", isEdible: false),
    ObjectModel(name: "chainsaw", isEdible: false),
    ObjectModel(name: "cigar", isEdible: false),
    ObjectModel(name: "controller", isEdible: false),
    ObjectModel(name: "cowboy", isEdible: false),
    ObjectModel(name: "crowbar", isEdible: false),
    ObjectModel(name: "driller", isEdible: false),
    ObjectModel(name: "electroshock", isEdible: false),
    ObjectModel(name: "flasks", isEdible: false),
    ObjectModel(name: "football", isEdible: false),
    ObjectModel(name: "gas", isEdible: false),
    ObjectModel(name: "gas2", isEdible: false),
    ObjectModel(name: "grater", isEdible: false),
    ObjectModel(name: "gun", isEdible: false),
    ObjectModel(name: "gun2", isEdible: false),
    ObjectModel(name: "gun3", isEdible: false),
    ObjectModel(name: "gun4", isEdible: false),
    ObjectModel(name: "gun5", isEdible: false),
    ObjectModel(name: "hammer", isEdible: false),
    ObjectModel(name: "hammer2", isEdible: false),
    ObjectModel(name: "hedgehog", isEdible: false),
    ObjectModel(name: "helm", isEdible: false),
    ObjectModel(name: "help", isEdible: false),
    ObjectModel(name: "honey2", isEdible: false),
    ObjectModel(name: "horseshoe", isEdible: false),
    ObjectModel(name: "hydrant", isEdible: false),
    ObjectModel(name: "indian", isEdible: false),
    ObjectModel(name: "insect", isEdible: true),
    ObjectModel(name: "insecticide", isEdible: false),
    ObjectModel(name: "iron", isEdible: false),
    ObjectModel(name: "kettle", isEdible: false),
    ObjectModel(name: "kitchen", isEdible: false),
    ObjectModel(name: "knife", isEdible: false),
    ObjectModel(name: "knife2", isEdible: false),
    ObjectModel(name: "knife3", isEdible: false),
    ObjectModel(name: "knuckles", isEdible: false),
    ObjectModel(name: "ladybug", isEdible: false),
    ObjectModel(name: "lamp", isEdible: false),
    ObjectModel(name: "mace", isEdible: false),
    ObjectModel(name: "mace2", isEdible: false),
    ObjectModel(name: "magic", isEdible: false),
    ObjectModel(name: "marvel", isEdible: false),
    ObjectModel(name: "match", isEdible: false),
    ObjectModel(name: "mitten", isEdible: false),
    ObjectModel(name: "mushroom2", isEdible: false),
    ObjectModel(name: "nail-trimmer", isEdible: false),
    ObjectModel(name: "origami", isEdible: false),
    ObjectModel(name: "paw", isEdible: false),
    ObjectModel(name: "perfume", isEdible: false),
    ObjectModel(name: "pet", isEdible: false),
    ObjectModel(name: "pet3", isEdible: false),
    ObjectModel(name: "pincers", isEdible: false),
    ObjectModel(name: "plunger", isEdible: false),
    ObjectModel(name: "poison", isEdible: false),
    ObjectModel(name: "pokeball", isEdible: false),
    ObjectModel(name: "poo", isEdible: false),
    ObjectModel(name: "poo2", isEdible: false),
    ObjectModel(name: "razor", isEdible: false),
    ObjectModel(name: "remote-control", isEdible: false),
    ObjectModel(name: "rocket", isEdible: false),
    ObjectModel(name: "rum", isEdible: false),
    ObjectModel(name: "sanding-machine", isEdible: false),
    ObjectModel(name: "save", isEdible: false),
    ObjectModel(name: "saw", isEdible: false),
    ObjectModel(name: "screwdriver", isEdible: false),
    ObjectModel(name: "sd-card", isEdible: false),
    ObjectModel(name: "segway", isEdible: false),
    ObjectModel(name: "set-square", isEdible: false),
    ObjectModel(name: "shoes", isEdible: false),
    ObjectModel(name: "shuriken", isEdible: false),
    ObjectModel(name: "smartwatch", isEdible: false),
    ObjectModel(name: "smoke", isEdible: false),
    ObjectModel(name: "snake", isEdible: true),
    ObjectModel(name: "snake2", isEdible: true),
    ObjectModel(name: "soldier", isEdible: false),
    ObjectModel(name: "spider", isEdible: false),
    ObjectModel(name: "spider2", isEdible: false),
    ObjectModel(name: "sword", isEdible: false),
    ObjectModel(name: "tape", isEdible: false),
    ObjectModel(name: "thor", isEdible: false),
    ObjectModel(name: "totem", isEdible: false),
    ObjectModel(name: "trash", isEdible: false),
    ObjectModel(name: "umbrella", isEdible: false),
    ObjectModel(name: "urban-guerrilla", isEdible: false),
    ObjectModel(name: "vase", isEdible: false),
    ObjectModel(name: "weed", isEdible: false),
    ObjectModel(name: "wind-rose", isEdible: false),
    ObjectModel(name: "wrench", isEdible: false),
    ObjectModel(name: "wrench2", isEdible: false)]
    
//Carnivorous
    let objectsArrayCarnivorous: [ObjectModel] = [ObjectModel(name: "badger", isEdible: false),
    ObjectModel(name: "bat", isEdible: false),
    ObjectModel(name: "bear", isEdible: false),
    ObjectModel(name: "bulldog", isEdible: false),
    ObjectModel(name: "cat3", isEdible: false),
    ObjectModel(name: "cheetah", isEdible: false),
    ObjectModel(name: "cheetah2", isEdible: false),
    ObjectModel(name: "cheetah3", isEdible: false),
    ObjectModel(name: "cobra", isEdible: false),
    ObjectModel(name: "crocodile", isEdible: false),
    ObjectModel(name: "dog", isEdible: false),
    ObjectModel(name: "dolphin", isEdible: false),
    ObjectModel(name: "eagle", isEdible: false),
    ObjectModel(name: "eel", isEdible: false),
    ObjectModel(name: "fennec", isEdible: false),
    ObjectModel(name: "ferret", isEdible: false),
    ObjectModel(name: "fishCarnivorous", isEdible: false),
    ObjectModel(name: "fox", isEdible: false),
    ObjectModel(name: "frog", isEdible: false),
    ObjectModel(name: "hammerhead-fish", isEdible: false),
    ObjectModel(name: "hyena", isEdible: false),
    ObjectModel(name: "hyena2", isEdible: false),
    ObjectModel(name: "jackal", isEdible: false),
    ObjectModel(name: "jellyfish", isEdible: false),
    ObjectModel(name: "lion", isEdible: false),
    ObjectModel(name: "manta-ray", isEdible: false),
    ObjectModel(name: "meerkat", isEdible: false),
    ObjectModel(name: "octopus", isEdible: false),
    ObjectModel(name: "otter", isEdible: false),
    ObjectModel(name: "own", isEdible: false),
    ObjectModel(name: "panda", isEdible: false),
    ObjectModel(name: "panther", isEdible: false),
    ObjectModel(name: "pelican", isEdible: false),
    ObjectModel(name: "penguin", isEdible: false),
    ObjectModel(name: "pliosaurus", isEdible: false),
    ObjectModel(name: "polar-bear", isEdible: false),
    ObjectModel(name: "pterosaurus", isEdible: false),
    ObjectModel(name: "raccoon", isEdible: false),
    ObjectModel(name: "red-panda", isEdible: false),
    ObjectModel(name: "scorpion", isEdible: false),
    ObjectModel(name: "sea-lion", isEdible: false),
    ObjectModel(name: "seagull", isEdible: false),
    ObjectModel(name: "seal", isEdible: false),
    ObjectModel(name: "shark", isEdible: false),
    ObjectModel(name: "siberian-husky", isEdible: false),
    ObjectModel(name: "skunk", isEdible: false),
    ObjectModel(name: "snake", isEdible: false),
    ObjectModel(name: "spider", isEdible: false),
    ObjectModel(name: "squid", isEdible: false),
    ObjectModel(name: "tiger", isEdible: false),
    ObjectModel(name: "tiger2", isEdible: false),
    ObjectModel(name: "tiger3", isEdible: false),
    ObjectModel(name: "toad", isEdible: false),
    ObjectModel(name: "tyrannosaurus-rex", isEdible: false),
    ObjectModel(name: "vulture", isEdible: false),
    ObjectModel(name: "walrus", isEdible: false),
    ObjectModel(name: "weasel", isEdible: false),
    ObjectModel(name: "whale", isEdible: false),
    ObjectModel(name: "wolf", isEdible: false),
    ObjectModel(name: "wolverine", isEdible: false),
    ObjectModel(name: "alpaca", isEdible: true),
    ObjectModel(name: "ankylosaurus", isEdible: true),
    ObjectModel(name: "ant", isEdible: true),
    ObjectModel(name: "antelope", isEdible: true),
    ObjectModel(name: "armadillo", isEdible: true),
    ObjectModel(name: "baboon", isEdible: true),
    ObjectModel(name: "beach2", isEdible: true),
    ObjectModel(name: "beaver", isEdible: true),
    ObjectModel(name: "bee2", isEdible: true),
    ObjectModel(name: "beetle", isEdible: true),
    ObjectModel(name: "bird", isEdible: true),
    ObjectModel(name: "bison", isEdible: true),
    ObjectModel(name: "brontosaurus", isEdible: true),
    ObjectModel(name: "buffalo", isEdible: true),
    ObjectModel(name: "bug", isEdible: true),
    ObjectModel(name: "bull", isEdible: true),
    ObjectModel(name: "butterfly", isEdible: true),
    ObjectModel(name: "camel", isEdible: true),
    ObjectModel(name: "canary", isEdible: true),
    ObjectModel(name: "chameleon", isEdible: true),
    ObjectModel(name: "chicken", isEdible: true),
    ObjectModel(name: "cockroach", isEdible: true),
    ObjectModel(name: "cow", isEdible: true),
    ObjectModel(name: "crab", isEdible: true),
    ObjectModel(name: "crow", isEdible: true),
    ObjectModel(name: "deer", isEdible: true),
    ObjectModel(name: "donkey", isEdible: true),
    ObjectModel(name: "duck", isEdible: true),
    ObjectModel(name: "elephant", isEdible: true),
    ObjectModel(name: "fish-flying", isEdible: true),
    ObjectModel(name: "fish-puffer", isEdible: true),
    ObjectModel(name: "fish", isEdible: true),
    ObjectModel(name: "fishgold", isEdible: true),
    ObjectModel(name: "flamingos", isEdible: true),
    ObjectModel(name: "giraffe", isEdible: true),
    ObjectModel(name: "goat", isEdible: true),
    ObjectModel(name: "gorilla", isEdible: true),
    ObjectModel(name: "hedgehog", isEdible: true),
    ObjectModel(name: "hen", isEdible: true),
    ObjectModel(name: "hippopotamus", isEdible: true),
    ObjectModel(name: "horse", isEdible: true),
    ObjectModel(name: "humming-bird", isEdible: true),
    ObjectModel(name: "kangaroo", isEdible: true),
    ObjectModel(name: "kiwi", isEdible: true),
    ObjectModel(name: "koala", isEdible: true),
    ObjectModel(name: "ladybug2", isEdible: true),
    ObjectModel(name: "lemur", isEdible: true),
    ObjectModel(name: "lama", isEdible: true),
    ObjectModel(name: "lizard", isEdible: true),
    ObjectModel(name: "lobster", isEdible: true),
    ObjectModel(name: "macaw", isEdible: true),
    ObjectModel(name: "mole", isEdible: true),
    ObjectModel(name: "moose", isEdible: true),
    ObjectModel(name: "mouse", isEdible: true),
    ObjectModel(name: "ostrich", isEdible: true),
    ObjectModel(name: "parasaurolophus", isEdible: true),
    ObjectModel(name: "parrot", isEdible: true),
    ObjectModel(name: "peacock", isEdible: true),
    ObjectModel(name: "platypus", isEdible: true),
    ObjectModel(name: "porcupine", isEdible: true),
    ObjectModel(name: "pufferFish", isEdible: true),
    ObjectModel(name: "rabbit", isEdible: true),
    ObjectModel(name: "rat", isEdible: true),
    ObjectModel(name: "rat2", isEdible: true),
    ObjectModel(name: "rhino", isEdible: true),
    ObjectModel(name: "salamander", isEdible: true),
    ObjectModel(name: "seahorse", isEdible: true),
    ObjectModel(name: "sheep", isEdible: true),
    ObjectModel(name: "shrimp", isEdible: true),
    ObjectModel(name: "sloth", isEdible: true),
    ObjectModel(name: "snail", isEdible: true),
    ObjectModel(name: "squirrel", isEdible: true),
    ObjectModel(name: "starfish", isEdible: true),
    ObjectModel(name: "swan", isEdible: true),
    ObjectModel(name: "toucan", isEdible: true),
    ObjectModel(name: "triceratops", isEdible: true),
    ObjectModel(name: "turkey", isEdible: true),
    ObjectModel(name: "turtle", isEdible: true),
    ObjectModel(name: "wildBoar", isEdible: true),
    ObjectModel(name: "woodpecker", isEdible: true),
    ObjectModel(name: "zebra", isEdible: true)]
    
//HardSoft
    let objectsArrayHardSoft: [ObjectModel] = [ObjectModel(name: "armchair", isEdible: true),
    ObjectModel(name: "balloon", isEdible: true),
    ObjectModel(name: "beard", isEdible: true),
    ObjectModel(name: "blouse", isEdible: true),
    ObjectModel(name: "brain", isEdible: true),
    ObjectModel(name: "bun", isEdible: true),
    ObjectModel(name: "cake6", isEdible: true),
    ObjectModel(name: "carpet", isEdible: true),
    ObjectModel(name: "chair", isEdible: true),
    ObjectModel(name: "clean", isEdible: true),
    ObjectModel(name: "cloud", isEdible: true),
    ObjectModel(name: "cottoBuds", isEdible: true),
    ObjectModel(name: "cotton", isEdible: true),
    ObjectModel(name: "cream12", isEdible: true),
    ObjectModel(name: "cute2", isEdible: true),
    ObjectModel(name: "drift", isEdible: true),
    ObjectModel(name: "duck2", isEdible: true),
    ObjectModel(name: "featherPen", isEdible: true),
    ObjectModel(name: "feet", isEdible: true),
    ObjectModel(name: "gloves", isEdible: true),
    ObjectModel(name: "hat", isEdible: true),
    ObjectModel(name: "jelly", isEdible: true),
    ObjectModel(name: "lips", isEdible: true),
    ObjectModel(name: "makeup", isEdible: true),
    ObjectModel(name: "maneeCat", isEdible: true),
    ObjectModel(name: "mattress", isEdible: true),
    ObjectModel(name: "neckPillow", isEdible: true),
    ObjectModel(name: "nipple", isEdible: true),
    ObjectModel(name: "painting", isEdible: true),
    ObjectModel(name: "peach2", isEdible: true),
    ObjectModel(name: "pillow", isEdible: true),
    ObjectModel(name: "rabbit2", isEdible: true),
    ObjectModel(name: "raincoat", isEdible: true),
    ObjectModel(name: "sandwich", isEdible: true),
    ObjectModel(name: "scarf", isEdible: true),
    ObjectModel(name: "shave", isEdible: true),
    ObjectModel(name: "sheep2", isEdible: true),
    ObjectModel(name: "slipper", isEdible: true),
    ObjectModel(name: "sofa", isEdible: true),
    ObjectModel(name: "spa", isEdible: true),
    ObjectModel(name: "sponge", isEdible: true),
    ObjectModel(name: "sponge2", isEdible: true),
    ObjectModel(name: "squirrel2", isEdible: true),
    ObjectModel(name: "teddyBear", isEdible: true),
    ObjectModel(name: "tissueRoll", isEdible: true),
    ObjectModel(name: "tomato2", isEdible: true),
    ObjectModel(name: "towel", isEdible: true),
    ObjectModel(name: "toy", isEdible: true),
    ObjectModel(name: "wool", isEdible: true),
    ObjectModel(name: "worm", isEdible: true),
    ObjectModel(name: "anchor2", isEdible: false),
    ObjectModel(name: "animal", isEdible: false),
    ObjectModel(name: "anvil2", isEdible: false),
    ObjectModel(name: "armor", isEdible: false),
    ObjectModel(name: "armor2", isEdible: false),
    ObjectModel(name: "axe6", isEdible: false),
    ObjectModel(name: "baseballBat", isEdible: false),
    ObjectModel(name: "bending", isEdible: false),
    ObjectModel(name: "bone", isEdible: false),
    ObjectModel(name: "brick", isEdible: false),
    ObjectModel(name: "choppingBoard", isEdible: false),
    ObjectModel(name: "concreteMixer", isEdible: false),
    ObjectModel(name: "constructionTools", isEdible: false),
    ObjectModel(name: "construction", isEdible: false),
    ObjectModel(name: "construction2", isEdible: false),
    ObjectModel(name: "cultures", isEdible: false),
    ObjectModel(name: "cute", isEdible: false),
    ObjectModel(name: "diamond", isEdible: false),
    ObjectModel(name: "drilling", isEdible: false),
    ObjectModel(name: "excavator", isEdible: false),
    ObjectModel(name: "food", isEdible: false),
    ObjectModel(name: "fryingPan", isEdible: false),
    ObjectModel(name: "household", isEdible: false),
    ObjectModel(name: "glacier", isEdible: false),
    ObjectModel(name: "gym", isEdible: false),
    ObjectModel(name: "gym2", isEdible: false),
    ObjectModel(name: "hammer4", isEdible: false),
    ObjectModel(name: "hammer5", isEdible: false),
    ObjectModel(name: "hat", isEdible: false),
    ObjectModel(name: "helmet", isEdible: false),
    ObjectModel(name: "helmet2", isEdible: false),
    ObjectModel(name: "horn", isEdible: false),
    ObjectModel(name: "iron3", isEdible: false),
    ObjectModel(name: "jackhammer", isEdible: false),
    ObjectModel(name: "jail", isEdible: false),
    ObjectModel(name: "journal", isEdible: false),
    ObjectModel(name: "knife4", isEdible: false),
    ObjectModel(name: "knight", isEdible: false),
    ObjectModel(name: "knight2", isEdible: false),
    ObjectModel(name: "mace3", isEdible: false),
    ObjectModel(name: "metal", isEdible: false),
    ObjectModel(name: "metalGear", isEdible: false),
    ObjectModel(name: "moon", isEdible: false),
    ObjectModel(name: "mountain2", isEdible: false),
    ObjectModel(name: "nail", isEdible: false),
    ObjectModel(name: "nail2", isEdible: false),
    ObjectModel(name: "paw2", isEdible: false),
    ObjectModel(name: "plumbing", isEdible: false),
    ObjectModel(name: "prehistoric", isEdible: false),
    ObjectModel(name: "robot", isEdible: false),
    ObjectModel(name: "safeBox", isEdible: false),
    ObjectModel(name: "saw2", isEdible: false),
    ObjectModel(name: "soldier2", isEdible: false),
    ObjectModel(name: "spade", isEdible: false),
    ObjectModel(name: "stone", isEdible: false),
    ObjectModel(name: "sword2", isEdible: false),
    ObjectModel(name: "table", isEdible: false),
    ObjectModel(name: "tooth", isEdible: false),
    ObjectModel(name: "vehicle", isEdible: false),
    ObjectModel(name: "weight", isEdible: false),
    ObjectModel(name: "wreckingBall", isEdible: false)]
    
//HotCold
    let objectsArrayHotCold: [ObjectModel] = [ObjectModel(name: "airConditioner", isEdible: true),
    ObjectModel(name: "bomb7", isEdible: true),
    ObjectModel(name: "camping", isEdible: true),
    ObjectModel(name: "candle", isEdible: true),
    ObjectModel(name: "chili2", isEdible: true),
    ObjectModel(name: "chimney", isEdible: true),
    ObjectModel(name: "constr", isEdible: true),
    ObjectModel(name: "dial", isEdible: true),
    ObjectModel(name: "fire", isEdible: true),
    ObjectModel(name: "flambe", isEdible: true),
    ObjectModel(name: "coffee3", isEdible: true),
    ObjectModel(name: "grease", isEdible: true),
    ObjectModel(name: "grill", isEdible: true),
    ObjectModel(name: "hairDryer", isEdible: true),
    ObjectModel(name: "heater", isEdible: true),
    ObjectModel(name: "heater2", isEdible: true),
    ObjectModel(name: "heater3", isEdible: true),
    ObjectModel(name: "heater4", isEdible: true),
    ObjectModel(name: "heater5", isEdible: true),
    ObjectModel(name: "hotCoffee", isEdible: true),
    ObjectModel(name: "idea", isEdible: true),
    ObjectModel(name: "instantNoodles", isEdible: true),
    ObjectModel(name: "iron2", isEdible: true),
    ObjectModel(name: "island", isEdible: true),
    ObjectModel(name: "keroseneLamp", isEdible: true),
    ObjectModel(name: "laserCuttingMachine", isEdible: true),
    ObjectModel(name: "lighter", isEdible: true),
    ObjectModel(name: "meteor", isEdible: true),
    ObjectModel(name: "microwave", isEdible: true),
    ObjectModel(name: "nuggets", isEdible: true),
    ObjectModel(name: "oven", isEdible: true),
    ObjectModel(name: "oven2", isEdible: true),
    ObjectModel(name: "pie4", isEdible: true),
    ObjectModel(name: "radiator", isEdible: true),
    ObjectModel(name: "radiator2", isEdible: true),
    ObjectModel(name: "smoke2", isEdible: true),
    ObjectModel(name: "steam", isEdible: true),
    ObjectModel(name: "sun", isEdible: true),
    ObjectModel(name: "teaPot", isEdible: true),
    ObjectModel(name: "tea6", isEdible: true),
    ObjectModel(name: "thermometer", isEdible: true),
    ObjectModel(name: "thermos", isEdible: true),
    ObjectModel(name: "toaster", isEdible: true),
    ObjectModel(name: "torch", isEdible: true),
    ObjectModel(name: "geyser", isEdible: true),
    ObjectModel(name: "urbanGuerrilla", isEdible: true),
    ObjectModel(name: "volcano", isEdible: true),
    ObjectModel(name: "airConditionerCold", isEdible: false),
    ObjectModel(name: "beer", isEdible: false),
    ObjectModel(name: "box", isEdible: false),
    ObjectModel(name: "christmasTree", isEdible: false),
    ObjectModel(name: "curling", isEdible: false),
    ObjectModel(name: "drift2", isEdible: false),
    ObjectModel(name: "fan", isEdible: false),
    ObjectModel(name: "fisher", isEdible: false),
    ObjectModel(name: "frappe3", isEdible: false),
    ObjectModel(name: "freeze", isEdible: false),
    ObjectModel(name: "fridge", isEdible: false),
    ObjectModel(name: "fridge2", isEdible: false),
    ObjectModel(name: "glass3", isEdible: false),
    ObjectModel(name: "hockey", isEdible: false),
    ObjectModel(name: "ice", isEdible: false),
    ObjectModel(name: "ice2", isEdible: false),
    ObjectModel(name: "iceberg", isEdible: false),
    ObjectModel(name: "iceberg2", isEdible: false),
    ObjectModel(name: "iceBox", isEdible: false),
    ObjectModel(name: "iceCream10", isEdible: false),
    ObjectModel(name: "iceCream11", isEdible: false),
    ObjectModel(name: "iceCube", isEdible: false),
    ObjectModel(name: "iceResurfacer", isEdible: false),
    ObjectModel(name: "iceSkate", isEdible: false),
    ObjectModel(name: "igloo", isEdible: false),
    ObjectModel(name: "milkshake2", isEdible: false),
    ObjectModel(name: "mitten2", isEdible: false),
    ObjectModel(name: "mountain", isEdible: false),
    ObjectModel(name: "penguin2", isEdible: false),
    ObjectModel(name: "polarBear", isEdible: false),
    ObjectModel(name: "skiPoles", isEdible: false),
    ObjectModel(name: "ski", isEdible: false),
    ObjectModel(name: "sledge", isEdible: false),
    ObjectModel(name: "snowboard", isEdible: false),
    ObjectModel(name: "snowflake", isEdible: false),
    ObjectModel(name: "snowflake2", isEdible: false),
    ObjectModel(name: "snowman", isEdible: false),
    ObjectModel(name: "temperature", isEdible: false),
    ObjectModel(name: "timeAndDate", isEdible: false),
    ObjectModel(name: "wind", isEdible: false),
    ObjectModel(name: "wine", isEdible: false),
    ObjectModel(name: "winter", isEdible: false),
    ObjectModel(name: "winter2", isEdible: false),
    ObjectModel(name: "winter3", isEdible: false)]
}

import AVFoundation

var backgroungMusicPlayer: AVAudioPlayer!

func playBackgroundMusic(fileName: String) {
    let resourceUrl = Bundle.main.url(forResource: fileName, withExtension: nil)
    guard let url = resourceUrl else {
        print("Could not file: \(fileName)")
        return
    }
    
    do {
        try backgroungMusicPlayer = AVAudioPlayer(contentsOf: url)
        backgroungMusicPlayer.numberOfLoops = -1
        backgroungMusicPlayer.prepareToPlay()
        backgroungMusicPlayer.play()
    } catch {
        print("Could not creat audio player!")
        return
    }
}
