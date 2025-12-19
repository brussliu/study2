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
  "番号" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "類型" varchar(50) COLLATE "pg_catalog"."default",
  "プロンプト概要" varchar(200) COLLATE "pg_catalog"."default",
  "プロンプト詳細" varchar(500) COLLATE "pg_catalog"."default",
  "戻る値種類" varchar(50) COLLATE "pg_catalog"."default",
  "ステータス" varchar(50) COLLATE "pg_catalog"."default",
  "難易度" varchar(50) COLLATE "pg_catalog"."default",
  "AiType" varchar(50) COLLATE "pg_catalog"."default",
  "回答" text COLLATE "pg_catalog"."default",
  "メモー１" text COLLATE "pg_catalog"."default",
  "メモー２" text COLLATE "pg_catalog"."default",
  "メモー３" text COLLATE "pg_catalog"."default",
  "メモー４" text COLLATE "pg_catalog"."default",
  "メモー５" text COLLATE "pg_catalog"."default",
  "登録ID" varchar(50) COLLATE "pg_catalog"."default",
  "更新ID" varchar(50) COLLATE "pg_catalog"."default",
  "登録日時" timestamp(6),
  "更新日時" timestamp(6)
)
;
