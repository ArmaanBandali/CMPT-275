//
//  SDDRGameLoop.swift
//  PARKinetics
//
//  Created by Kai Sackville-Hii on 2019-11-25.
//  Copyright © 2019 Kai Sackville-Hii. All rights reserved.
//
// Apendix A:
// below are the extracted keypoints from the given image as defined above, these
// vectors should be used for validating our positions. if you where to print foundRightLeg after
// correctly exctracting the pose then the output would look something like this...
/*
 
 [Keypoint(id: 12, position: (0.46718414098836103, 0.5267753033732557), score: 0.880, part: HumanSkeleton), Keypoint(id: 14, position: (0.46964614215064143, 0.6969218024451065), score: 0.641, part: HumanSkeleton), Keypoint(id: 16, position: (0.5093932652751759, 0.807005468914259), score: 0.536, part: HumanSkeleton)]
 
 */
// Each element in the array is a Keypoint object, each element has an id which lets you
// know which keypoint you it is, its position, and a accuracy score. The position is normalized
// from 0 to 1, with (0, 0) = (x, y) = the top left of an up oriented image.
// Use the table below to map an id with its keypoint. See this link for more info
// https://docs.fritz.ai/develop/vision/pose-estimation/ios.html
/*
 
 id | keypoint
 ---|---------
 0  | nose
 1  | left eye
 2  | right eye
 3  | left ear
 4  | right ear
 5  | left shoulder
 6  | right shoulder
 7  | left elbow
 8  | right elbow
 9  | left wrist
 10 | right wrist
 11 | left hip
 12 | right hip
 13 | left knee
 14 | right knee
 15 | left ankle
 16 | right ankle
 
 */

import Foundation
import UIKit
import Fritz

class PoseEstimate: UIViewController {
    // below are all the keypoints of the HumanSkeleton Object whitch we would like to
    // extract from the image. To make it easier on ourselves we divide the body into sections
    // seen below
    private let leftArmParts: [HumanSkeleton] = [.leftWrist, .leftElbow, .leftShoulder]
    private let rightArmParts: [HumanSkeleton] = [.rightWrist, .rightElbow, .rightShoulder]
    private let leftLegParts: [HumanSkeleton] = [.leftAnkle, .leftKnee, .leftHip]
    private let rightLegParts: [HumanSkeleton] = [.rightAnkle, .rightKnee, .rightHip]
    private let faceParts: [HumanSkeleton] = [.rightEar, .leftEar, .rightEye, .leftEye, .nose]
    
    // See Apendix A
    private var foundLeftArm: [Keypoint] = [] as! [Keypoint<HumanSkeleton>]
    private var foundRightArm: [Keypoint] = [] as! [Keypoint<HumanSkeleton>]
    private var foundLeftLeg: [Keypoint] = [] as! [Keypoint<HumanSkeleton>]
    private var foundRightLeg: [Keypoint] = [] as! [Keypoint<HumanSkeleton>]
    private var foundFace: [Keypoint] = [] as! [Keypoint<HumanSkeleton>]
    
    // MARK: Helper Fuctions
    // DES: takes the keypoints and formats into our body section vectors
    // PRE: system was able to estimate pose in poseResult
    // POST: each body vector will be updated accordingly
    func formatKeypoints(poseResult: FritzVisionPoseResult<HumanSkeleton>) {
        var tempLeftArm: [Keypoint] = [] as! [Keypoint<HumanSkeleton>]
        var tempRightArm: [Keypoint] = [] as! [Keypoint<HumanSkeleton>]
        var tempLeftLeg: [Keypoint] = [] as! [Keypoint<HumanSkeleton>]
        var tempRightLeg: [Keypoint] = [] as! [Keypoint<HumanSkeleton>]
        var tempFace: [Keypoint] = [] as! [Keypoint<HumanSkeleton>]
        
        // attempt to decode results
        guard let poseEstimate = poseResult.pose() else {
            print("error could not extract pose from image")
            return
        }
        
        for keypoint in poseEstimate.keypoints {
            if leftArmParts.contains(keypoint.part) {
                tempLeftArm.append(keypoint)
            }
            else if rightArmParts.contains(keypoint.part) {
                tempRightArm.append(keypoint)
            }
            else if leftLegParts.contains(keypoint.part) {
                tempLeftLeg.append(keypoint)
            }
            else if rightLegParts.contains(keypoint.part) {
                tempRightLeg.append(keypoint)
            }
            else if faceParts.contains(keypoint.part) {
                tempFace.append(keypoint)
            }
        }
        
        foundLeftArm = tempLeftArm
        foundRightArm = tempRightArm
        foundLeftLeg = tempLeftLeg
        foundRightLeg = tempRightLeg
        foundFace = tempFace
    }
    
    // DES: main function for verifiying our expected poses
    // PRE: A set of poses must be predefined, each case will have an id (0 - inf) this function
    //      will verifiy based on the current poseItr (id).
    // POST: if pose mathces current expected pose, func returns true
    func verifyPose(poseNumber: Int) -> Bool {
        var verified = false
        
        switch poseNumber {
        case 0:
            let rWristAboveShoulder = abs(Float(foundLeftArm[2].position.y) - Float(foundLeftArm[0].position.y)) < 0.1
            let rWristLeftOfShoulder = Float(foundLeftArm[2].position.x) > Float(foundLeftArm[0].position.x)
            
            verified = rWristAboveShoulder && rWristLeftOfShoulder
        case 1:
            let rWristAboveShoulder = abs(Float(foundLeftArm[2].position.y) - Float(foundLeftArm[0].position.y)) < 0.1
            let rWristLeftOfShoulder = Float(foundLeftArm[2].position.x) > Float(foundLeftArm[0].position.x)
            
            verified = rWristAboveShoulder && rWristLeftOfShoulder
        case 2:
            let rWristAboveShoulder = abs(Float(foundLeftArm[2].position.y) - Float(foundLeftArm[0].position.y)) < 0.1
            let rWristLeftOfShoulder = Float(foundLeftArm[2].position.x) > Float(foundLeftArm[0].position.x)
            
            verified = rWristAboveShoulder && rWristLeftOfShoulder
        default:
            verified = false
        }
        
        return(verified)
    }
}