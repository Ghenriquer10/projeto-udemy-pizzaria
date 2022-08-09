-- AlterTable
ALTER TABLE "tb_users" ALTER COLUMN "created_at" DROP NOT NULL,
ALTER COLUMN "created_up" DROP NOT NULL;

-- CreateTable
CREATE TABLE "tb_categories" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "created_up" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "tb_categories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tb_products" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "price" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "banner" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "created_up" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "category_id" TEXT NOT NULL,

    CONSTRAINT "tb_products_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tb_order" (
    "id" TEXT NOT NULL,
    "table" INTEGER NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT false,
    "draft" BOOLEAN NOT NULL DEFAULT true,
    "name" TEXT,
    "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "created_up" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "tb_order_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tb_item" (
    "id" TEXT NOT NULL,
    "amount" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "created_up" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "order_id" TEXT NOT NULL,
    "product_id" TEXT NOT NULL,

    CONSTRAINT "tb_item_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "tb_products" ADD CONSTRAINT "tb_products_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "tb_categories"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tb_item" ADD CONSTRAINT "tb_item_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "tb_products"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tb_item" ADD CONSTRAINT "tb_item_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "tb_order"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
