<template>
    <div class="views-gerenjiankangshuju-detail">
        <div>
            <el-card class="box-card">
                <template #header>
                    <div class="clearfix">
                        <span class="title"> 个人健康数据详情 </span>
                    </div>
                </template>

                <div id="printdetail">
                    <el-descriptions class="margin-top" :column="3" border>
                        <el-descriptions-item label="姓名"> {{ map.xingming }} </el-descriptions-item>
                        <el-descriptions-item label="性别"> {{ map.xingbie }} </el-descriptions-item>
                        <el-descriptions-item label="身高"> {{ map.shengao }} </el-descriptions-item>
                        <el-descriptions-item label="体重"> {{ map.tizhong }} </el-descriptions-item>
                        <el-descriptions-item label="日期"> {{ map.riqi }} </el-descriptions-item>
                        <el-descriptions-item label="舒张压"> {{ map.shuzhangya }} </el-descriptions-item>
                        <el-descriptions-item label="收缩压"> {{ map.shousuoya }} </el-descriptions-item>
                        <el-descriptions-item label="血糖"> {{ map.xuetang }} </el-descriptions-item>
                        <el-descriptions-item label="心率"> {{ map.xinlv }} </el-descriptions-item>
                        <el-descriptions-item label="用户"> {{ map.yonghu }} </el-descriptions-item>
                    </el-descriptions>

                    <el-descriptions direction="vertical" class="margin-top" :column="1" border>
                        <el-descriptions-item label="备注"> {{ map.beizhu }} </el-descriptions-item>
                    </el-descriptions>
                </div>
                <div class="no-print" v-if="isShowBtn">
                    <el-button @click="$router.go(-1)">返回</el-button>
                    <el-button @click="$print('#printdetail')">打印</el-button>
                </div>
            </el-card>
        </div>
    </div>
</template>

<script setup>
    import http from "@/utils/ajax/http";
    import DB from "@/utils/db";

    import { ref, reactive, watch, computed } from "vue";
    import { useRoute } from "vue-router";
    import { session } from "@/utils/utils";
    import { extend } from "@/utils/extend";
    import { useGerenjiankangshujuFindById, canGerenjiankangshujuFindById } from "@/module";

    const route = useRoute();
    const props = defineProps({
        id: {
            type: [Number, String],
        },
        isShowBtn: {
            type: Boolean,
            default: true,
        },
    });

    // 获取详情页面的一行数据,当url参数id变更时，自动
    const map = useGerenjiankangshujuFindById(props.id);
    // 当url参数id变更时，自动更新map中的数据
    watch(
        () => props.id,
        (id) => {
            canGerenjiankangshujuFindById(id).then((res) => {
                extend(map, res);
            });
        }
    );
    // end 获取详情页面的一行数据
</script>

<style scoped lang="scss">
    .views-gerenjiankangshuju-detail {
    }
</style>
