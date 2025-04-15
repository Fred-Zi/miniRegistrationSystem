## 数据库设计文档（挂号系统）

| 序号 | 数据表名      | 中文名称           |
| ---- | ------------- | ------------------ |
| 1    | employee      | 医务人员表         |
| 2    | category      | 科室分类表         |
| 3    | dish          | 挂号项目表         |
| 4    | dish_flavor   | 挂号选项表         |
| 5    | setmeal       | 体检套餐表         |
| 6    | setmeal_dish  | 套餐项目关系表     |
| 7    | user          | 患者表             |
| 8    | address_book  | 患者地址表         |
| 9    | shopping_cart | 预约暂存表         |
| 10   | orders        | 挂号订单表         |
| 11   | order_detail  | 订单明细表         |

### 1. employee

医务人员表，用于存储医院工作人员信息：

| 字段名      | 数据类型    | 说明               | 医疗场景解释                 |
| ----------- | ----------- | ------------------ | ---------------------------- |
| id          | bigint      | 主键               | 医务人员工号                 |
| name        | varchar(32) | 姓名               | 医生/护士真实姓名            |
| username    | varchar(32) | 用户名             | 系统登录账号（如：D1001）    |
| password    | varchar(64) | 密码               | 加密后的登录密码             |
| phone       | varchar(11) | 联系电话           | 工作联系方式                 |
| sex         | varchar(2)  | 性别               | 医生性别                     |
| id_number   | varchar(18) | 身份证号           | 医务人员身份证               |
| status      | int         | 账号状态           | 1正常 0停职                 |
| create_time | datetime    | 创建时间           | 入职时间                     |
| update_time | datetime    | 最后修改时间       | 信息更新时间                 |
| create_user | bigint      | 创建人id           | 系统管理员ID                 |
| update_user | bigint      | 最后修改人id       | 最近操作的管理员ID           |

### 2. category

科室分类表，用于医院科室管理：

| 字段名      | 数据类型    | 说明               | 医疗场景解释                 |
| ----------- | ----------- | ------------------ | ---------------------------- |
| id          | bigint      | 主键               | 科室编号                     |
| name        | varchar(32) | 分类名称           | 科室名称（如：心血管内科）   |
| type        | int         | 分类类型           | 1普通科室 2特色诊疗中心     |
| sort        | int         | 排序字段           | 科室展示优先级               |
| status      | int         | 状态               | 1正常接诊 0停诊             |
| create_time | datetime    | 创建时间           | 科室成立时间                 |
| update_time | datetime    | 最后修改时间       | 信息更新时间                 |
| create_user | bigint      | 创建人id           | 系统管理员ID                 |
| update_user | bigint      | 最后修改人id       | 最近操作的管理员ID           |

### 3. dish

挂号项目表，存储可预约的诊疗服务：

| 字段名      | 数据类型      | 说明               | 医疗场景解释                 |
| ----------- | ------------- | ------------------ | ---------------------------- |
| id          | bigint        | 主键               | 诊疗项目编号                 |
| name        | varchar(32)   | 项目名称           | 如"专家门诊-心血管内科"      |
| category_id | bigint        | 分类id             | 所属科室编号                 |
| price       | decimal(10,2) | 项目价格           | 挂号费用                     |
| image       | varchar(255)  | 图片路径           | 科室环境/医生照片            |
| description | varchar(255)  | 项目描述           | 诊疗范围说明                 |
| status      | int           | 接诊状态           | 1可预约 0停号               |
| create_time | datetime      | 创建时间           | 项目创建时间                 |
| update_time | datetime      | 最后修改时间       | 信息更新时间                 |
| create_user | bigint        | 创建人id           | 科室管理员ID                 |
| update_user | bigint        | 最后修改人id       | 最近操作的管理员ID           |

### 4. dish_flavor

挂号选项表，存储可选的诊疗细节：

| 字段名  | 数据类型     | 说明               | 医疗场景解释                 |
| ------- | ------------ | ------------------ | ---------------------------- |
| id      | bigint       | 主键               | 选项编号                     |
| dish_id | bigint       | 项目id             | 关联诊疗项目                 |
| name    | varchar(32)  | 选项名称           | 如"就诊时段"、"医生选择"     |
| value   | varchar(255) | 选项值             | 如"上午9:00-11:00"、"张医生" |

### 5. setmeal

体检套餐表，存储组合检查项目：

| 字段名      | 数据类型      | 说明               | 医疗场景解释                 |
| ----------- | ------------- | ------------------ | ---------------------------- |
| id          | bigint        | 主键               | 套餐编号                     |
| name        | varchar(32)   | 套餐名称           | 如"入职体检套餐"             |
| category_id | bigint        | 分类id             | 体检中心编号                 |
| price       | decimal(10,2) | 套餐价格           | 套餐总费用                   |
| image       | varchar(255)  | 图片路径           | 套餐示意图                   |
| description | varchar(255)  | 套餐描述           | 包含项目说明                 |
| status      | int           | 套餐状态           | 1可预约 0下架               |
| create_time | datetime      | 创建时间           | 套餐创建时间                 |
| update_time | datetime      | 最后修改时间       | 信息更新时间                 |
| create_user | bigint        | 创建人id           | 体检中心管理员ID             |
| update_user | bigint        | 最后修改人id       | 最近操作的管理员ID           |

### 6. setmeal_dish

套餐项目关系表，记录套餐包含的检查项目：

| 字段名     | 数据类型      | 说明               | 医疗场景解释                 |
| ---------- | ------------- | ------------------ | ---------------------------- |
| id         | bigint        | 主键               | 关系编号                     |
| setmeal_id | bigint        | 套餐id             | 关联体检套餐                 |
| dish_id    | bigint        | 项目id             | 关联检查项目                 |
| name       | varchar(32)   | 项目名称           | 如"血常规检查"               |
| price      | decimal(10,2) | 项目单价           | 单项检查费用                 |
| copies     | int           | 检查次数           | 如"2次血糖检测"              |

### 7. user

患者信息表，存储就诊患者数据：

| 字段名      | 数据类型     | 说明               | 医疗场景解释                 |
| ----------- | ------------ | ------------------ | ---------------------------- |
| id          | bigint       | 主键               | 患者编号                     |
| openid      | varchar(45)  | 微信标识           | 患者微信唯一标识             |
| name        | varchar(32)  | 患者姓名           | 实名认证姓名                 |
| phone       | varchar(11)  | 联系电话           | 患者手机号码                 |
| sex         | varchar(2)   | 性别               | 患者性别                     |
| id_number   | varchar(18)  | 身份证号           | 患者身份证信息               |
| avatar      | varchar(500) | 头像路径           | 微信头像地址                 |
| create_time | datetime     | 注册时间           | 首次使用系统时间             |

### 8. address_book

患者地址表，记录常用就诊地址：

| 字段名        | 数据类型     | 说明               | 医疗场景解释                 |
| ------------- | ------------ | ------------------ | ---------------------------- |
| id            | bigint       | 主键               | 地址编号                     |
| user_id       | bigint       | 患者id             | 关联患者信息                 |
| consignee     | varchar(50)  | 联系人             | 紧急联系人姓名               |
| sex           | varchar(2)   | 性别               | 联系人性别                   |
| phone         | varchar(11)  | 联系电话           | 紧急联系方式                 |
| province_code | varchar(12)  | 省份编码           | 行政区划编码                 |
| province_name | varchar(32)  | 省份名称           | 如"浙江省"                   |
| city_code     | varchar(12)  | 城市编码           | 市级行政区划                 |
| city_name     | varchar(32)  | 城市名称           | 如"杭州市"                   |
| district_code | varchar(12)  | 区县编码           | 区级编码                     |
| district_name | varchar(32)  | 区县名称           | 如"西湖区"                   |
| detail        | varchar(200) | 详细地址           | 如"文三路123号"              |
| label         | varchar(100) | 地址标签           | 如"家庭地址"、"工作单位"     |
| is_default    | tinyint(1)   | 是否默认           | 1首选地址 0备用地址          |

### 9. shopping_cart

预约暂存表，存储待提交的预约项目：

| 字段名      | 数据类型      | 说明               | 医疗场景解释                 |
| ----------- | ------------- | ------------------ | ---------------------------- |
| id          | bigint        | 主键               | 暂存记录编号                 |
| name        | varchar(32)   | 项目名称           | 如"专家门诊-儿科"            |
| image       | varchar(255)  | 项目图片           | 科室导引图                   |
| user_id     | bigint        | 患者id             | 关联患者信息                 |
| dish_id     | bigint        | 挂号项目id         | 单次挂号项目                 |
| setmeal_id  | bigint        | 套餐id             | 体检套餐项目                 |
| dish_flavor | varchar(50)   | 就诊选项           | 如"就诊时段：周三上午"       |
| number      | int           | 预约数量           | 同项目重复预约次数           |
| amount      | decimal(10,2) | 项目单价           | 挂号费/套餐费                |
| create_time | datetime      | 创建时间           | 加入预约车时间               |

### 10. orders

挂号订单表，存储完整的预约记录：

| 字段名                  | 数据类型      | 说明               | 医疗场景解释                 |
| ----------------------- | ------------- | ------------------ | ---------------------------- |
| id                      | bigint        | 主键               | 订单编号                     |
| number                  | varchar(50)   | 订单号             | 唯一业务流水号               |
| status                  | int           | 订单状态           | 1待支付 2已预约 3已完成 4已取消 5已退号 |
| user_id                 | bigint        | 患者id             | 关联患者信息                 |
| address_book_id         | bigint        | 地址id             | 就诊地址记录                 |
| order_time              | datetime      | 下单时间           | 预约提交时间                 |
| checkout_time           | datetime      | 支付时间           | 费用结算时间                 |
| pay_method              | int           | 支付方式           | 1微信支付 2医保支付          |
| pay_status              | tinyint       | 支付状态           | 0未支付 1已支付 2已退款      |
| amount                  | decimal(10,2) | 订单金额           | 实际支付金额                 |
| remark                  | varchar(100)  | 患者备注           | 病情简述/特殊需求            |
| phone                   | varchar(11)   | 联系电话           | 就诊联系电话                 |
| address                 | varchar(255)  | 就诊地址           | 详细就诊地点                 |
| user_name               | varchar(32)   | 患者姓名           | 冗余存储姓名                 |
| consignee               | varchar(32)   | 联系人             | 紧急联系人姓名               |
| cancel_reason           | varchar(255)  | 取消原因           | 患者自主取消说明             |
| rejection_reason        | varchar(255)  | 拒单原因           | 医院退号原因                 |
| cancel_time             | datetime      | 取消时间           | 操作取消时间                 |
| estimated_delivery_time | datetime      | 预计就诊时间       | 系统分配的就诊时段           |
| delivery_status         | tinyint       | 就诊状态           | 1已就诊 0未就诊             |
| delivery_time           | datetime      | 实际就诊时间       | 医生接诊时间戳               |
| pack_amount             | int           | 病历费用           | 病历本工本费                 |
| tableware_number        | int           | 病历本数量         | 领取的病历本数量             |
| tableware_status        | tinyint       | 病历领取状态       | 1已领取 0未领取             |

### 11. order_detail

订单明细表，记录订单中的具体项目：

| 字段名      | 数据类型      | 说明               | 医疗场景解释                 |
| ----------- | ------------- | ------------------ | ---------------------------- |
| id          | bigint        | 主键               | 明细编号                     |
| name        | varchar(32)   | 项目名称           | 如"血常规检查"               |
| image       | varchar(255)  | 项目图片           | 检查项目示意图               |
| order_id    | bigint        | 订单id             | 关联主订单                   |
| dish_id     | bigint        | 挂号项目id         | 单次挂号记录                 |
| setmeal_id  | bigint        | 套餐id             | 体检套餐记录                 |
| dish_flavor | varchar(50)   | 就诊选项           | 如"就诊医生：王主任"         |
| number      | int           | 项目数量           | 检查项次数                   |
| amount      | decimal(10,2) | 项目单价           | 单项费用记录                 |

