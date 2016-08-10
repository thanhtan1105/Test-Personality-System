//
//  Define.swift
//  XMLProject
//
//  Created by Le Thanh Tan on 8/2/16.
//  Copyright © 2016 Le Thanh Tan. All rights reserved.
//

import Foundation

let kUDCurrentQuestion = "currentQuestion"
let kUDQuestionCount = 51
let kUDPersonality = "kUDPersonality"
let kUDUser = "kUDUser"
let kUDWantToRetestPersonality = "kUDWantToRetestPersonality"


// API SERVER

let serverURL = "http://10.211.55.4:8080/XMLProject/webresources"
let loginURL = serverURL + "/api/login"
let sendPersonalityAnswerURL = serverURL + "/api/question/ProcessPersonality"
let getInforPersonality = serverURL + "/api/getperonality"
let getTemplateQuestion = serverURL + "/api/getTemplateQuestion"
let getPersonalityURL = serverURL + "/api/getCurrentPersonality"