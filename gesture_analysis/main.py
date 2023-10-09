import sys
import cv2
import mediapipe as mp
import numpy as np
from PIL import ImageGrab
mp_drawing = mp.solutions.drawing_utils
mp_drawing_styles = mp.solutions.drawing_styles
mp_holistic = mp.solutions.holistic
# sys.stdout = open('01_violin.txt', 'w')
sys.stdout = open('00_test.txt', 'w')
frame = -1

# For webcam input:
cap = cv2.VideoCapture(1)
with mp_holistic.Holistic(
    min_detection_confidence=0.5,
    min_tracking_confidence=0.5) as holistic:
  while cap.isOpened():
    screen = np.array(ImageGrab.grab())
    screen = cv2.cvtColor(src=screen, code=cv2.COLOR_BGR2RGB)
    image = screen
    # To improve performance, optionally mark the image as not writeable to
    # pass by reference.
    image.flags.writeable = False
    image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
    results = holistic.process(image)

    # Draw landmark annotation on the image.
    image.flags.writeable = True
    image = cv2.cvtColor(image, cv2.COLOR_RGB2BGR)
    # mp_drawing.draw_landmarks(
    #     image,
    #     results.face_landmarks,
    #     mp_holistic.FACEMESH_CONTOURS,
    #     landmark_drawing_spec=None,
    #     connection_drawing_spec=mp_drawing_styles
    #     .get_default_face_mesh_contours_style())
    mp_drawing.draw_landmarks(
        image,
        results.pose_landmarks,
        mp_holistic.POSE_CONNECTIONS,
        landmark_drawing_spec=mp_drawing_styles
        .get_default_pose_landmarks_style())
    # Every fingers may not be needed yet.
    mp_drawing.draw_landmarks(
        image,
        results.left_hand_landmarks,
        landmark_drawing_spec=mp_drawing_styles
        .get_default_pose_landmarks_style())
    mp_drawing.draw_landmarks(
        image,
        results.right_hand_landmarks,
        landmark_drawing_spec=mp_drawing_styles
        .get_default_pose_landmarks_style())
    # Flip the image horizontally for a selfie-view display.
    # cv2.imshow('MediaPipe Holistic', cv2.flip(image, 1))
    cv2.imshow('MediaPipe Holistic', image)
    if cv2.waitKey(5) & 0xFF == 27:
      break
    
    try:
        landmarks = results.pose_landmarks.landmark
        # left arm
        print(frame)
        # for k in range(12):
        #   print(k+11, landmarks[k+11].x, landmarks[k+11].y, landmarks[k+11].z)
        ## print arms only
        for k in range(6):
          print(k+11, landmarks[k+11].x, landmarks[k+11].y, landmarks[k+11].z)

        # print hands.. 0, [1 4], [5 8], [9 12], [13 16], [17, 20]
        lefthand = results.left_hand_landmarks.landmark
        print(0, lefthand[0].x, lefthand[0].y, lefthand[0].z)
        print(1, lefthand[1].x, lefthand[1].y, lefthand[1].z)
        print(4, lefthand[4].x, lefthand[4].y, lefthand[4].z)
        print(5, lefthand[5].x, lefthand[5].y, lefthand[5].z)
        print(8, lefthand[8].x, lefthand[8].y, lefthand[8].z)
        print(9, lefthand[9].x, lefthand[9].y, lefthand[9].z)
        print(12, lefthand[12].x, lefthand[12].y, lefthand[12].z)
        print(13, lefthand[13].x, lefthand[13].y, lefthand[13].z)
        print(16, lefthand[16].x, lefthand[16].y, lefthand[16].z)
        print(17, lefthand[17].x, lefthand[17].y, lefthand[17].z)
        print(20, lefthand[20].x, lefthand[20].y, lefthand[20].z)

        # print hands.. 0, [1 4], [5 8], [9 12], [13 16], [17, 20]
        righthand = results.right_hand_landmarks.landmark
        print(0, righthand[0].x, righthand[0].y, righthand[0].z)
        print(1, righthand[1].x, righthand[1].y, righthand[1].z)
        print(4, righthand[4].x, righthand[4].y, righthand[4].z)
        print(5, righthand[5].x, righthand[5].y, righthand[5].z)
        print(8, righthand[8].x, righthand[8].y, righthand[8].z)
        print(9, righthand[9].x, righthand[9].y, righthand[9].z)
        print(12, righthand[12].x, righthand[12].y, righthand[12].z)
        print(13, righthand[13].x, righthand[13].y, righthand[13].z)
        print(16, righthand[16].x, righthand[16].y, righthand[16].z)
        print(17, righthand[17].x, righthand[17].y, righthand[17].z)
        print(20, righthand[20].x, righthand[20].y, righthand[20].z)

        # print nose, and body
        print(0, landmarks[0].x, landmarks[0].y, landmarks[0].z)
        print(23, landmarks[23].x, landmarks[23].y, landmarks[23].z)
        print(24, landmarks[24].x, landmarks[24].y, landmarks[24].z)

        # landmarks = results.left_hand_landmarks.landmark
        # print(landmarks[4])
        frame = frame-1
    except:
        pass    
cap.release()
sys.stdout.close()

# body [0 nose, 23 24 body]
# Left [(11, 13, 15), (17, 19, 21)] // arm + fingers (thumb, pick, pinky)
# Right [(12, 14, 16), (18, 20, 22)]
