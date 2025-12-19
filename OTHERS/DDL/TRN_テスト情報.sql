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

 Date: 18/12/2025 13:54:20
*/


-- ----------------------------
-- Table structure for TRN_テスト情報
-- ----------------------------
DROP TABLE IF EXISTS "public"."TRN_テスト情報";
CREATE TABLE "public"."TRN_テスト情報" (
  "テストSEQ" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "テスト学年" varchar(20) COLLATE "pg_catalog"."default",
  "テスト名称" varchar(100) COLLATE "pg_catalog"."default",
  "期間FROM" timestamp(6),
  "期間TO" timestamp(6),
  "内容SEQ" varchar(500) COLLATE "pg_catalog"."default",
  "登録ID" varchar(20) COLLATE "pg_catalog"."default",
  "更新ID" varchar(20) COLLATE "pg_catalog"."default",
  "登録日時" timestamp(6),
  "更新日時" timestamp(6)
)
;