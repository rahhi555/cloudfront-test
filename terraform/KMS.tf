# カスタマーマスターキーの定義
resource "aws_kms_key" "home_care_navi_second" {
  # 説明
  description = "home_care_navi_second Customer Master Key"
  # 自動ローテーション機能を有効にする。
  enable_key_rotation = true
}

# カスタマーマスターキーのUUIDのエイリアス定義
resource "aws_kms_alias" "home_care_navi_second" {
  # エイリアスの表示名。名前は[alias」という単語で始まり、その後にスラッシュ（alias /）が続く必要がある
  name = "alias/home_care_navi_second"
  target_key_id = aws_kms_key.home_care_navi_second.key_id
}

