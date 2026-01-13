/*
 Navicat Premium Data Transfer

 Source Server         : study2
 Source Server Type    : PostgreSQL
 Source Server Version : 110005
 Source Host           : localhost:54320
 Source Catalog        : study2
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 110005
 File Encoding         : 65001

 Date: 18/12/2025 13:54:07
*/


-- ----------------------------
-- Table structure for AI質問情報管理
-- ----------------------------
DROP TABLE IF EXISTS "public"."AI質問情報管理";
CREATE TABLE "public"."AI質問情報管理" (
  "番号" varchar(50) NOT NULL,
  "類型" varchar(50),
  "プロンプト概要" varchar(200),
  "プロンプト詳細" varchar(500),
  "戻る値種類" varchar(50),
  "ステータス" varchar(50),
  "難易度" varchar(50),
  "AiType" varchar(50),
  "回答" text,
  "メモー１" text,
  "メモー２" text,
  "メモー３" text,
  "メモー４" text,
  "メモー５" text,
  "登録ID" varchar(50),
  "更新ID" varchar(50),
  "登録日時" timestamp(6),
  "更新日時" timestamp(6)
)
;
