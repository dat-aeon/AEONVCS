//
//  SendChatQuestionViewModel.swift
//  AEONVCS
//
//  Created by Ant on 22/09/2020.
//  Copyright © 2020 AEON microfinance. All rights reserved.
//


class SendChatQuestionViewModel {
    
    func sendChatQuestionAnswer(customerId: String,chatBotQuestionAndAnswerId: String ,question: String,answer:String,success: @escaping (SendChatQuestionResponse) -> Void,failure: @escaping (String) -> Void){
        SendChatQuestionModel.init().sendChatQuestion(customerId: customerId, chatBotQuestionAndAnswerId: chatBotQuestionAndAnswerId, question: question, answer: answer) { (result) in
            if result.status ==  Constants.STATUS_200 {
                success(result)
            }
        } failure: { (error) in
            failure(error)
        }

    }
    
   

}
//MultiLoginModel.init().makeMultiLogin(customerId: customerId, loginDeviceId: loginDeviceId, success: { (result) in
//             if result.status == Constants.STATUS_200 {
//                           success(result)
//
//                       } else {
//                           failure(result.status)
//                       }
//            MultiLoginModel.init().makeMultiLogin(customerId: customerId, loginDeviceId: loginDeviceId, success: { (result) in
//                        if result.status == Constants.STATUS_200 {
//                                                      success(result)
//
//                                                  } else {
//                                                      failure(result.status)
//                                                  }
//                    }) { (error) in
//                        failure(error)
//                    }
//
//        }) { (error) in
//            failure(error)
//        }
