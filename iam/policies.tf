data "aws_iam_policy_document" "tiko_nudge" {
  statement {
    sid = "publishSqs"

    actions = local.publish_queue

    resources = [
data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-test"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-handle-inbound-message-command"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-scheduler-commands"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-chatter-send-message"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-mobile-inbox-service"],
      "arn:aws:sqs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${var.environment}-*-acl-give-tiko-miles",
    ]


  }

  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-test"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-nudge-offer-validations"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-nudge-participants"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-nudge-scheduler-notifications"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-acl-give-tiko-miles-responses"]
    ]

  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-miles-incentive-given"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-reminder-sent"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-trial-started"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-trial-ended"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-trial-group-assigned"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-trial-incentive-given"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-trial-results"]
    ]

  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

data "aws_iam_policy_document" "tiko_nudge_reminders" {
  statement {
    sid = "publishSqs"

    actions = local.publish_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-handle-inbound-message-command"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-scheduler-commands"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-chatter-send-message"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-mobile-inbox-service"],
      "arn:aws:sqs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${var.environment}-*-acl-give-tiko-miles",
    ]


  }

  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-nudge-reminders-service"]
    ]

  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-reminder-sent"]
    ]

  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

data "aws_iam_policy_document" "tiko_nudge_lottery" {
  statement {
    sid = "publishSqs"

    actions = local.publish_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-scheduler-commands"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-chatter-send-message"]
    ]

  }

  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-lottery-service"]
    ]

  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-nudge-lottery"]
    ]

  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

data "aws_iam_policy_document" "tiko_service_validation" {
  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-service-validation-service"]
    ]

  }

  statement {
    sid = "publishSqs"

    actions = local.publish_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-platform-token-token-commands"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-chatter-send-message"]
    ]

  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-service-validation"]
    ]

  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

data "aws_iam_policy_document" "tiko_nudge_trials" {
  statement {
    sid = "publishSqs"

    actions = local.publish_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-scheduler-commands"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-chatter-send-message"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-mobile-inbox-service"]
    ]


  }

  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-trials-service"]
    ]

  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-nudge-trials"]
    ]

  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

data "aws_iam_policy_document" "tiko_nudge_announcements" {
  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-announcements-service"]
    ]

  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-nudge-announcements"],
    ]

  }

  statement {
    sid = "s3"

    actions = local.s3_put_permissions

    resources = [
      data.terraform_remote_state.s3.outputs.bucket_tiko_public_assets,
      "${data.terraform_remote_state.s3.outputs.bucket_tiko_public_assets}/*"
    ]
  }

  statement {
    sid = "publishSqs"

    actions = local.publish_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-scheduler-commands"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-mobile-inbox-service"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-chatter-send-message"]
    ]

  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

data "aws_iam_policy_document" "tiko_platform_file_storer" {
  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-platform-file-storer"]
    ]

  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-platform-file-storer"],
    ]

  }

  statement {
    sid = "s3"

    actions = local.s3_put_permissions

    resources = [
      data.terraform_remote_state.s3.outputs.bucket_platform_file_storer,
      "${data.terraform_remote_state.s3.outputs.bucket_platform_file_storer}/*"
    ]
  }

  statement {
    sid = "publishSqs"

    actions = local.publish_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-platform-file-storer"]
    ]

  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}


data "aws_iam_policy_document" "tiko_platform_mobile_authenticator" {
  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-mobile-authenticator-service"]
    ]

  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-mobile-sessions"]
    ]
  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

data "aws_iam_policy_document" "tiko_platform_mobile_inbox" {
  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-mobile-inbox-service"]
    ]

  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-mobile-inbox-messages"]
    ]
  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

data "aws_iam_policy_document" "tiko_feedback" {
  statement {
    sid = "publishSqs"

    actions = local.publish_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-scheduler-commands"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-chatter-start-conversation"]
    ]


  }

  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-feedback-service"]
    ]

  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-feedback-requested"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-feedback-ended"],
    ]

  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

data "aws_iam_policy_document" "tiko_message_gateway" {
  statement {
    sid = "publishSqs"

    actions = local.publish_queue

    resources = [
      "arn:aws:sqs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${var.environment}-*-acl-gateway-messages",
      "arn:aws:sqs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${var.environment}-sms-gateway-service",
      "arn:aws:sqs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${var.environment}-telegram-gateway-service",
      "arn:aws:sqs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${var.environment}-whatsapp-gateway-service"
    ]

  }

  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-send-messages"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-message-gateway-participants"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-platform-message-gateway-inbound-messages"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-acl-inbound-messages"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-handle-inbound-message-command"],
    ]

  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-participant-message-sent"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-participant-message-received"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-unknown-participant-message-received"]
    ]

  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

data "aws_iam_policy_document" "tiko_platform_message_gateway" {
  statement {
    sid = "publishSqs"

    actions = local.publish_queue

    resources = [
      "arn:aws:sqs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${var.environment}-*-acl-gateway-messages",
      "arn:aws:sqs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${var.environment}-sms-gateway-service",
      "arn:aws:sqs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${var.environment}-telegram-gateway-service",
      "arn:aws:sqs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${var.environment}-whatsapp-gateway-service"
    ]

  }

  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-send-messages"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-message-gateway-participants"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-platform-message-gateway-inbound-messages"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-acl-inbound-messages"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-handle-inbound-message-command"],
    ]

  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-participant-message-sent"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-participant-message-received"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-unknown-participant-message-received"]
    ]

  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

data "aws_iam_policy_document" "tiko_platform_sms_gateway" {
  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-sms-gateway-service"]
    ]

  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-inbound-messages"]
    ]

  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

data "aws_iam_policy_document" "tiko_platform_telegram_gateway" {
  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-telegram-gateway-service"]
    ]

  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-inbound-messages"]
    ]

  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

data "aws_iam_policy_document" "tiko_platform_whatsapp_gateway" {
  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-whatsapp-gateway-service"]
    ]

  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-inbound-messages"]
    ]

  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

data "aws_iam_policy_document" "tiko_fraud" {
  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-fraud-queue"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-fraud-business-created-queue"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-fraud-business-updated-queue"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-fraud-enrollment-queue"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-fraud-voice-biometric-auth-failed-queue"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-fraud-participant-changes-queue"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-trust-fraud-connector"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-trust-fraud-facility"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-trust-fraud-organisation"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-trust-fraud-retailer-and-stockist"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-trust-fraud-facial-recognition-matched-face"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-trust-fraud-facial-recognition-sign-in-attempt-exceeded"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-trust-fraud-connectors-uuid-updates"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-trust-fraud-service-validation"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-trust-fraud-location"],
    ]
  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-facial-recognition-notification"],
    ]
  }


  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

data "aws_iam_policy_document" "tiko_fraud_dashboard" {
  statement {
    sid = "sendEmail"

    actions = [
      "ses:SendEmail"
    ]

    resources = [
      "arn:aws:ses:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:identity/noreply@triggerise.org"
    ]
  }

  statement {
    sid = "s3"

    actions = local.s3_put_permissions

    resources = [
      data.terraform_remote_state.s3.outputs.bucket_trust_report_images,
      "${data.terraform_remote_state.s3.outputs.bucket_trust_report_images}/*",
      data.terraform_remote_state.s3.outputs.bucket_tiko_trust,
      "${data.terraform_remote_state.s3.outputs.bucket_tiko_trust}/*"
    ]
  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-trust-fraud-dashboard-report-template"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-trust-fraud-dashboard-report"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-trust-fraud-dashboard-service-validation-verifications"],
    ]
  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }

  statement {
    sid = "publishSqs"

    actions = local.publish_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-trust-status-tracker-commands"],
    ]
  }
}

data "aws_iam_policy_document" "tiko_facial_recognition" {
  statement {
    sid = "rekognitionCollections"

    actions = [
      "rekognition:IndexFaces",
      "rekognition:SearchFacesByImage",
      "rekognition:DeleteFaces"
    ]

    resources = [
      "arn:aws:rekognition:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:collection/*"
    ]
  }


  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-trust-facial-recognition-delete-connector"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-trust-facial-recognition-create-connector"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-trust-facial-recognition-update-connector"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-trust-facial-recognition-uuid-update"],
    ]

  }

  statement {
    sid = "rekognitionDetectFaces"

    actions = [
      "rekognition:DetectFaces",
    ]

    resources = [
      "*"
    ]
  }


  statement {
    sid = "s3RecognitionBuckets"

    actions = local.s3_put_permissions

    resources = [
      data.terraform_remote_state.s3.outputs.bucket_tiko_facial_recognition,
      "${data.terraform_remote_state.s3.outputs.bucket_tiko_facial_recognition}/*"
    ]
  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-facial-recognition-notification"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-facial-recognition-matched-face"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-facial-recognition-sign-in-attempts-exceeded"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-facial-recognition-validation"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-trust-facial-recognition-image-reset"],
    ]
  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }

}

data "aws_iam_policy_document" "tiko_platform_jwt_validator" {

  statement {
    sid = "s3readKeyExchange"

    actions = local.s3_get_permissions

    resources = [
      data.terraform_remote_state.s3.outputs.bucket_tiko_mvc_key_exchange,
      "${data.terraform_remote_state.s3.outputs.bucket_tiko_mvc_key_exchange}/*"
    ]
  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

data "aws_iam_policy_document" "tiko_platform_token" {
  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-platform-token-token-commands"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-platform-token-scheduler"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-platform-token-chatter-messages"],

    ]
  }

  statement {
    sid = "publishSqs"

    actions = local.publish_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-scheduler-commands"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-chatter-send-message"],
    ]

  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-token-created-deleted"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-token-validations"],
    ]
  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}


data "aws_iam_policy_document" "tiko_connect_brainiac" {
  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-brainiac-contacts"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-brainiac-accounts"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-brainiac-scheduler"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-brainiac-mfa-login-session"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-connect-brainiac-suspicious-actor"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-connect-brainiac-chatter-messages"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-connect-brainiac-connector-trust-status-changed"],
    ]
  }

  statement {
    sid = "publishSqs"

    actions = local.publish_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-scheduler-commands"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-chatter-send-message"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-chatter-start-conversation"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-chatter-start-conversation-high-priority"],
    ]

  }
  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-brainiac-contacts"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-brainiac-accounts"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-brainiac-organisation"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-brainiac-connector"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-brainiac-facility"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-brainiac-retailer-and-stockist"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-brainiac-connector-uuid-update"],
    ]
  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

data "aws_iam_policy_document" "tiko_connect_crm_bridge" {
  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-brainiac-contacts"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-brainiac-accounts"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-brainiac-scheduler"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-brainiac-mfa-login-session"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-connect-crm-bridge-location"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-crm-bridge-connector-trust-status-changed"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-connect-crm-bridge-intervention"],
    ]
  }

  statement {
    sid = "publishSqs"

    actions = local.publish_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-scheduler-commands"],
    ]

  }
  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-brainiac-contacts"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-brainiac-accounts"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-brainiac-organisation"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-brainiac-connector"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-brainiac-facility"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-brainiac-retailer-and-stockist"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-brainiac-connector-uuid-update"],
    ]
  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

data "aws_iam_policy_document" "tiko_platform_scheduler" {

  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-scheduler-commands"],
    ]

  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-scheduler-notifications"],
    ]

  }

  statement {
    sid = "manageSchedule"

    actions = local.manage_schedule

    resources = [
      "arn:aws:scheduler:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:schedule/${var.environment}-tiko-platform-scheduler-group/*"
    ]
  }

  statement {
    sid = "passRole"

    actions = ["iam:PassRole"]

    resources = [
      aws_iam_role.eventbridge_scheduler.arn
    ]
  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

data "aws_iam_policy_document" "eventbridge_scheduler" {
  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-scheduler-notifications"],
    ]

  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

data "aws_iam_policy_document" "tiko_rafiki_card" {

  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-rafiki-card-state-mvc-events"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-rafiki-card-scheduler"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-rafiki-terminate-card"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-rafiki-card-profiles-merged"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-rafiki-card-card-authentication"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-rafiki-card-chatter-messages"]
    ]
  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-rafiki-cards-generated"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-rafiki-card-state-changed"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-rafiki-card-card-authentication"]
    ]

  }

  statement {
    sid = "publishSqs"

    actions = local.publish_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-scheduler-commands"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-chatter-send-message"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-chatter-start-conversation"]
    ]

  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }

  statement {
    sid = "s3Access"

    actions = local.s3_put_permissions

    resources = [
      data.terraform_remote_state.s3.outputs.bucket_tiko_rafiki_card_batches,
      "${data.terraform_remote_state.s3.outputs.bucket_tiko_rafiki_card_batches}/*",
      data.terraform_remote_state.s3.outputs.bucket_tiko_rafiki_card_designs,
      "${data.terraform_remote_state.s3.outputs.bucket_tiko_rafiki_card_designs}/*"
    ]
  }
}

data "aws_iam_policy_document" "tiko_loyalty_spending" {

  statement {
    sid = "publishSqs"

    actions = local.publish_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-loyalty-ledger-ingestion"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-rafiki-card-card-authentication"],
    ]
  }

  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-loyalty-spending-ledger-responses"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-loyalty-spending-campaign-ingestion"],
    ]
  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-loyalty-spending-redemption-events"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-loyalty-spending-request-events"]
    ]
  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

data "aws_iam_policy_document" "tiko_loyalty_perks" {

  statement {
    sid = "s3"

    actions = local.s3_put_permissions

    resources = [
      data.terraform_remote_state.s3.outputs.bucket_loyalty_perks_photos,
      "${data.terraform_remote_state.s3.outputs.bucket_loyalty_perks_photos}/*"
    ]
  }

  statement {
    sid = "publishSqs"

    actions = local.publish_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-scheduler-commands"],
    ]
  }

  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-loyalty-perks-opportunities"],
    ]
  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-loyalty-perks-events"],
    ]
  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]
  }
}

data "aws_iam_policy_document" "tiko_loyalty_mobile_api" {
  statement {
    sid = "s3"

    actions = local.s3_put_permissions

    resources = [
      data.terraform_remote_state.s3.outputs.bucket_offer_validation_photos,
      "${data.terraform_remote_state.s3.outputs.bucket_offer_validation_photos}/*"
    ]
  }
}

data "aws_iam_policy_document" "tiko_loyalty_reporter" {

  statement {
    sid = "publishSqs"

    actions = local.publish_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-chatter-send-message"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-mobile-inbox-service"],
    ]
  }

  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-loyalty-reporter-operator-ingestion"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-loyalty-reporter-relay-ingestion"],
    ]
  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-loyalty-reporter-relay-events"],
    ]
  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

data "aws_iam_policy_document" "tiko_loyalty_budget" {
  statement {
    sid = "publishSqs"

    actions = local.publish_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-loyalty-ledger-ingestion"],
    ]
  }

  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-loyalty-budget-warden-ingestion"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-loyalty-budget-ledger-responses"],
    ]
  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-loyalty-budget-fund-events"],
    ]
  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

data "aws_iam_policy_document" "tiko_loyalty_cashouts" {
  statement {
    sid = "publishSqs"

    actions = local.publish_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-scheduler-commands"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-loyalty-cashouts-ongoing-cashouts"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-loyalty-ledger-ingestion"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-loyalty-cashout-commands"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-loyalty-cashouts-engine-ingestion"],
    ]
  }

  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-loyalty-cashouts-notifications"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-loyalty-cashout-commands"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-loyalty-cashouts-ongoing-cashouts"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-loyalty-cashouts-provider-callbacks"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-loyalty-cashouts-ledger-responses"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-loyalty-cashouts-external-updates"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-loyalty-cashouts-engine-ingestion"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-loyalty-cashouts-planner-ingestion"],
    ]
  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-loyalty-cashout-events"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-loyalty-provider-callbacks"]
    ]
  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

data "aws_iam_policy_document" "tiko_loyalty_incentives" {
  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-loyalty-incentive-opportunities"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-loyalty-incentives-ledger-responses"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-loyalty-incentives-notifications"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-loyalty-incentives-external-updates"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-loyalty-incentives-evaluator-ingestion"],
    ]
  }

  statement {
    sid = "publishSqs"

    actions = local.publish_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-loyalty-ledger-ingestion"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-scheduler-commands"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-loyalty-incentives-evaluator-ingestion"],
    ]
  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-loyalty-incentive-given"]
    ]
  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

data "aws_iam_policy_document" "tiko_loyalty_ledger" {
  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-loyalty-ledger-ingestion"],
    ]
  }

  statement {
    sid = "publishSqs"

    actions = local.publish_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-scheduler-commands"],
    ]
  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-loyalty-ledger-journal-events"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-loyalty-ledger-owner-events"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-loyalty-ledger-responses"]
    ]
  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

data "aws_iam_policy_document" "tiko_loyalty_entities" {
  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-loyalty-entities-ingestion"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-redrive-tiko-loyalty-entities-ingestion-new"],
    ]
  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-loyalty-entities-events"],
    ]
  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

data "aws_iam_policy_document" "tiko_product_basket" {
  statement {
    sid = "s3"

    actions = local.s3_put_permissions

    resources = [
      data.terraform_remote_state.s3.outputs.bucket_tiko_mvc_key_exchange,
      "${data.terraform_remote_state.s3.outputs.bucket_tiko_mvc_key_exchange}/*"
    ]
  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

data "aws_iam_policy_document" "tiko_rafiki_enrolment" {

  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-rafiki-unknown-participant-message"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-rafiki-enrolment-chatter-messages"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-rafiki-enrolment-scheduler"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-rafiki-enrolment-connector"],
    ]
  }

  statement {
    sid = "publishSqs"

    actions = local.publish_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-chatter-send-message"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-chatter-start-conversation"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-scheduler-commands"],
    ]

  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-rafiki-enrolment"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-rafiki-profiles"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-rafiki-mvc-profiles"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-participant-message-received"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-rafiki-contacts"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-voice-events"],
    ]

  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}



data "aws_iam_policy_document" "tiko_platform_chatter" {

  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-chatter-send-message"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-chatter-send-message-high-priority"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-chatter-participant-inbound"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-chatter-start-conversation"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-chatter-start-conversation-high-priority"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-chatter-utils"]
    ]

  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-conversation-ended"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-conversation-started"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-participant-request-received"]
    ]

  }

  statement {
    sid = "publishSqs"

    actions = local.publish_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-send-messages"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-scheduler-commands"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-handle-inbound-message-command"]
    ]

  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

data "aws_iam_policy_document" "tiko_platform_voice_biometrics" {

  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-voice-biometrics-service"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-voice-biometrics-rafiki-profiles"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-platform-voice-biometrics-scheduler"]
    ]
  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-voice-events"]
    ]

  }

  statement {
    sid = "publishSqs"

    actions = local.publish_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-scheduler-commands"],
    ]

  }

  statement {
    sid = "s3full"

    actions = local.s3_put_permissions

    resources = [
      data.terraform_remote_state.s3.outputs.bucket_tiko_voice_files,
      "${data.terraform_remote_state.s3.outputs.bucket_tiko_voice_files}/*"
    ]
  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }

  statement {
    sid = "s3Access"

    actions = local.s3_put_permissions

    resources = [
      "arn:aws:s3:::${var.environment}-tiko-voice-files/*",
      "arn:aws:s3:::${var.environment}-tiko-voice-files"
    ]
  }
}

data "aws_iam_policy_document" "tiko_rafiki_mobile_api" {
  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

data "aws_iam_policy_document" "tiko_rafiki_profile" {

  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-rafiki-profile-scheduler"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-rafiki-profile-chatter-messages"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-profile-mvc-rafikis"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-rafiki-profile-service-validation-messages"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-rafiki-profile-trust-status-updates"],
    ]

  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-rafiki-profiles"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-rafiki-contacts"],
    ]

  }

  statement {
    sid = "publishSqs"

    actions = local.publish_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-scheduler-commands"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-chatter-send-message"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-chatter-start-conversation"],
    ]

  }

  statement {
    sid = "s3full"

    actions = local.s3_put_permissions

    resources = [
      data.terraform_remote_state.s3.outputs.bucket_tiko_voice_files,
      "${data.terraform_remote_state.s3.outputs.bucket_tiko_voice_files}/*"
    ]
  }

  statement {
    sid = "s3read"

    actions = local.s3_get_permissions

    resources = [
      data.terraform_remote_state.s3.outputs.bucket_tiko_mvc_key_exchange,
      "${data.terraform_remote_state.s3.outputs.bucket_tiko_mvc_key_exchange}/*"
    ]
  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

data "aws_iam_policy_document" "tiko_trust_status_tracker" {

  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-status-tracker-facial-recognition-validation"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-trust-status-tracker-mfa-login-session"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-trust-status-tracker-mfa-logout-session"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-trust-status-tracker-connector"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-trust-status-tracker-facility"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-trust-status-tracker-organisation"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-trust-status-tracker-retailer-and-stockist"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-trust-status-tracker-connectors-uuid-updates"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-trust-status-tracker-commands"],
    ]
  }

  statement {
    sid = "publishSqs"

    actions = local.publish_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-chatter-send-message"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-mobile-authenticator-service"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-mobile-inbox-service"],
    ]
  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-trust-status-tracker-suspicious-actor"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-trust-status-changes"],
    ]

  }

  statement {
    sid = "s3RecognitionBuckets"

    actions = local.s3_put_permissions

    resources = [
      data.terraform_remote_state.s3.outputs.bucket_tiko_facial_recognition,
      "${data.terraform_remote_state.s3.outputs.bucket_tiko_facial_recognition}/*"
    ]
  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

data "aws_iam_policy_document" "tiko_trust_case_management" {

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

# tfsec:ignore:aws-iam-no-policy-wildcards
data "aws_iam_policy_document" "data_dbt_docs" {

  statement {
    sid = "accessAthena"

    actions = [
      "athena:*"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    sid = "accessGlue"

    actions = [
      "glue:*"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    sid = "s3Buckets"

    actions = local.s3_put_permissions


    resources = [
      "arn:aws:s3:::${var.environment}-tiko-raw",
      "arn:aws:s3:::${var.environment}-tiko-raw/*",
      "arn:aws:s3:::${var.environment}-tiko-curated",
      "arn:aws:s3:::${var.environment}-tiko-curated/*",
      "arn:aws:s3:::${var.environment}-tiko-cleaned",
      "arn:aws:s3:::${var.environment}-tiko-cleaned/*",
    ]
  }
}

data "aws_iam_policy_document" "tiko_offer_validation_decider" {
  statement {
    sid = "consumeSqs"

    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-offer-validation-rafiki-events"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-offer-validation-connect-events"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-offer-validation-machine-learning-outcome"],
    ]
  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic


    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-offer-validation-product-photo-claim-denied-events"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-offer-validation-product-photo-claim-verified-events"],

    ]
  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

data "aws_iam_policy_document" "tiko_offer_validation_mobile_api" {

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-offer-validation-product-photo-claim-created"]
    ]

  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

data "aws_iam_policy_document" "tiko_opportunity_cerebro" {
  statement {
    sid     = "consumeSqs"
    actions = local.consume_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-opportunity-cerebro-notifications"],
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-tiko-opportunity-cerebro-location-ingestion"],
    ]
  }

  statement {
    sid = "publishSqs"

    actions = local.publish_queue

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.queue_arns["${var.environment}-scheduler-commands"],
    ]
  }

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-opportunity-location-events"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-opportunity-country-events"],
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-tiko-opportunity-project-events"],
    ]
  }


  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

# NEW POLICIES
resource "aws_iam_policy" "tikoplatform_nudge" {
  name        = "${var.environment}-tiko-nudge"
  path        = "/"
  description = "tiko-nudge policy"

  policy = data.aws_iam_policy_document.tiko_nudge.json
}

resource "aws_iam_policy" "tikoplatform_nudge_reminders" {
  name        = "${var.environment}-tiko-nudge-reminders"
  path        = "/"
  description = "tiko-nudge-reminders policy"

  policy = data.aws_iam_policy_document.tiko_nudge_reminders.json
}

resource "aws_iam_policy" "tikoplatform_fraud" {
  name        = "${var.environment}-tiko-fraud"
  path        = "/"
  description = "tiko-fraud policy"

  policy = data.aws_iam_policy_document.tiko_fraud.json
}

resource "aws_iam_policy" "tikoplatform_fraud_dashboard" {
  name        = "${var.environment}-tiko-fraud-dashboard"
  path        = "/"
  description = "tiko-fraud-dashboard policy"

  policy = data.aws_iam_policy_document.tiko_fraud_dashboard.json
}

resource "aws_iam_policy" "tikoplatform_facial_recognition" {
  name        = "${var.environment}-tiko-facial-recognition"
  path        = "/"
  description = "tiko-facial-recognition"

  policy = data.aws_iam_policy_document.tiko_facial_recognition.json
}


resource "aws_iam_policy" "tikoplatform_scheduler" {
  name        = "${var.environment}-tiko-platform-scheduler"
  path        = "/"
  description = "tiko-platform-scheduler"

  policy = data.aws_iam_policy_document.tiko_platform_scheduler.json
}

resource "aws_iam_policy" "tikoplatform_file_storer" {
  name        = "${var.environment}-tiko-platform-file-storer"
  path        = "/"
  description = "tiko-platform-file-storer"

  policy = data.aws_iam_policy_document.tiko_platform_file_storer.json
}

resource "aws_iam_policy" "tikoplatform_data_dbt_docs" {
  name        = "${var.environment}-dbt-docs"
  path        = "/"
  description = "dbt-docs"

  policy = data.aws_iam_policy_document.data_dbt_docs.json
}

data "aws_iam_policy_document" "external_partner_offer_validation" {

  statement {
    sid = "publishTopic"

    actions = local.publish_topic

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.topic_arns["${var.environment}-external-partner-offer-validation"]
    ]
  }

  statement {
    sid = "kmsDecrypt"

    actions = local.kms_access

    resources = [
      data.terraform_remote_state.sqs_sns.outputs.kms_key_id
    ]

  }
}

data "aws_iam_policy_document" "kargo_controller" {

  statement {
    sid = "ecr"

    actions = [
      "ecr:DescribeRepositories",
      "ecr:DescribeImages",
      "ecr:ListImages",
      "ecr:GetAuthorizationToken",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "tiko_insights_url_generator" {

  statement {
    sid = "s3"

    actions = [
      "s3:GetObject",
      "s3:HeadObject",
      "s3:ListBucket",
      "s3:HeadBucket"
    ]

    resources = [
      "arn:aws:s3:::${var.environment}-loyalty-perks-photos",
      "arn:aws:s3:::${var.environment}-loyalty-perks-photos/*"
    ]
  }


}
