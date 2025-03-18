export default [
    {
        label: "账号管理",
        to: "",
        children: [
            {
                label: "管理员账号管理",
                to: { path: "/admin/admins" },
            },
            {
                label: "管理员账号添加",
                to: { path: "/admin/admins/add" },
            },
            {
                label: "密码修改",
                to: { path: "/admin/mod" },
            },
        ],
    },
    {
        label: "用户管理",
        to: "",
        children: [
            {
                label: "用户查询",
                to: { path: "/admin/yonghu" },
            },
        ],
    },
    {
        label: "医生管理",
        to: "",
        children: [
            {
                label: "医生添加",
                to: { path: "/admin/yisheng/add" },
            },
            {
                label: "医生查询",
                to: { path: "/admin/yisheng" },
            },
        ],
    },
    {
        label: "排班管理",
        to: "",
        children: [
            {
                label: "排班查询",
                to: { path: "/admin/paiban" },
            },
        ],
    },
    {
        label: "预约挂号管理",
        to: "",
        children: [
            {
                label: "预约挂号查询",
                to: { path: "/admin/yuyueguahao" },
            },
        ],
    },
    {
        label: "心理诊疗方案管理",
        to: "",
        children: [

            {
                label: "心理诊疗方案查询",
                to: { path: "/admin/xinlizhenliaofangan" },
            },
        ],
    },
    {
        label: "试卷管理",
        to: "",
        children: [
            {
                label: "试卷添加",
                to: { path: "/admin/shijuan/add" },
            },
            {
                label: "试卷查询",
                to: { path: "/admin/shijuan" },
            },
            {
                label: "试题查询",
                to: { path: "/admin/shiti" },
            },
            {
                label: "结果查询",
                to: { path: "/admin/jieguo" },
            },
            {
                label: "成绩查询",
                to: { path: "/admin/chengji" },
            },
        ],
    },
    {
        label: "文章管理",
        to: "",
        children: [
            {
                label: "文章查询",
                to: { path: "/admin/wenzhang" },
            },
        ],
    },
    {
        label: "通知管理",
        to: "",
        children: [
            {
                label: "通知添加",
                to: { path: "/admin/tongzhi/add" },
            },
            {
                label: "通知查询",
                to: { path: "/admin/tongzhi" },
            },
        ],
    },
    {
        label: "个人健康数据管理",
        to: "",
        children: [

            {
                label: "个人健康数据查询",
                to: { path: "/admin/gerenjiankangshuju" },
            },
        ],
    },
    {
        label: "药品管理",
        to: "",
        children: [
            {
                label: "类别添加",
                to: { path: "/admin/leibie/add" },
            },
            {
                label: "类别查询",
                to: { path: "/admin/leibie" },
            },
            {
                label: "药品添加",
                to: { path: "/admin/yaopin/add" },
            },
            {
                label: "药品查询",
                to: { path: "/admin/yaopin" },
            },
        ],
    },
    {
        label: "订单管理",
        to: "",
        children: [
            {
                label: "订单查询",
                to: { path: "/admin/dingdan/xiadanren" },
            },
        ],
    },
    {
        label: "轮播图管理",
        to: "",
        children: [
            {
                label: "轮播图添加",
                to: { path: "/admin/lunbotu/add" },
            },
            {
                label: "轮播图查询",
                to: { path: "/admin/lunbotu" },
            },
        ],
    },
];
