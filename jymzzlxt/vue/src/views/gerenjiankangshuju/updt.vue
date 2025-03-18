<template>
    <div class="views-gerenjiankangshuju-updt">
        <div>
            <el-card class="box-card">
                <template #header>
                    <div class="clearfix">
                        <span class="title"> 添加个人健康数据 </span>
                    </div>
                </template>

                <el-form :model="form" ref="formModel" :label-width="labelWidth" status-icon validate-on-rule-change>
                    <el-form-item label="姓名" prop="xingming" required :rules="[{required:true, message:'请填写姓名'}]">
                        <el-input type="text" placeholder="输入姓名" style="width: 450px" v-model="form.xingming" />
                    </el-form-item>

                    <el-form-item label="性别" prop="xingbie" required :rules="[{required:true, message:'请填写性别'}]">
                        <el-select v-model="form.xingbie"
                            ><el-option label="男" value="男"></el-option>
                            <el-option label="女" value="女"></el-option>
                        </el-select>
                    </el-form-item>

                    <el-form-item label="身高" prop="shengao" required :rules="[{required:true, message:'请填写身高'}]">
                        <el-input type="text" placeholder="输入身高" style="width: 450px" v-model="form.shengao" />
                    </el-form-item>

                    <el-form-item label="体重" prop="tizhong"> <el-input type="text" placeholder="输入体重" style="width: 450px" v-model="form.tizhong" /> </el-form-item>

                    <el-form-item label="日期" prop="riqi" required :rules="[{required:true, message:'请填写日期'}]">
                        <el-date-picker v-model="form.riqi" type="date" value-format="YYYY-MM-DD" placeholder="选择日期"> </el-date-picker>
                    </el-form-item>

                    <el-form-item
                        label="舒张压"
                        prop="shuzhangya"
                        required
                        :rules="[{required:true, message:'请填写舒张压'}, {validator:rule.checkNumber, message:'输入一个有效数字'}]"
                    >
                        <el-input type="number" placeholder="输入舒张压" style="width: 450px" v-model.number="form.shuzhangya" />
                    </el-form-item>

                    <el-form-item
                        label="收缩压"
                        prop="shousuoya"
                        required
                        :rules="[{required:true, message:'请填写收缩压'}, {validator:rule.checkNumber, message:'输入一个有效数字'}]"
                    >
                        <el-input type="number" placeholder="输入收缩压" style="width: 450px" v-model.number="form.shousuoya" />
                    </el-form-item>

                    <el-form-item label="血糖" prop="xuetang" required :rules="[{required:true, message:'请填写血糖'}, {validator:rule.checkNumber, message:'输入一个有效数字'}]">
                        <el-input type="number" placeholder="输入血糖" style="width: 450px" v-model.number="form.xuetang" />
                    </el-form-item>

                    <el-form-item label="心率" prop="xinlv" required :rules="[{required:true, message:'请填写心率'}, {validator:rule.checkNumber, message:'输入一个有效数字'}]">
                        <el-input type="number" placeholder="输入心率" style="width: 450px" v-model.number="form.xinlv" />
                    </el-form-item>

                    <el-form-item label="备注" prop="beizhu"> <el-input type="textarea" v-model="form.beizhu"></el-input> </el-form-item>

                    <el-form-item label="用户" prop="yonghu"> <el-input v-model="form.yonghu" readonly style="width: 250px"></el-input> </el-form-item>

                    <el-form-item v-if="btnText">
                        <el-button type="primary" @click="submit">{{ btnText }}</el-button>
                    </el-form-item>
                </el-form></el-card
            >
        </div>
    </div>
</template>

<script setup>
    import http from "@/utils/ajax/http";
    import DB from "@/utils/db";
    import rule from "@/utils/rule";
    import router from "@/router";

    import { ref, reactive, computed } from "vue";
    import { useRoute } from "vue-router";
    import { session } from "@/utils/utils";
    import { ElMessage, ElMessageBox } from "element-plus";
    import { useGerenjiankangshujuFindById, canGerenjiankangshujuFindById, canGerenjiankangshujuUpdate } from "@/module";

    const route = useRoute();
    const props = defineProps({
        id: [String, Number],
        btnText: {
            type: String,
            default: "保存",
        },
        isRead: {
            type: Boolean,
            default: true,
        },
        isHouxu: {
            type: Boolean,
            default: true,
        },
        labelWidth: {
            type: String,
            default: "140px",
        },
    });
    const form = useGerenjiankangshujuFindById(props.id);
    const emit = defineEmits(["success"]);
    const formModel = ref();
    const loading = ref(false);

    const submit = () => {
        formModel.value.validate().then((res) => {
            if (loading.value) return;
            loading.value = true;
            canGerenjiankangshujuUpdate(form).then(
                (res) => {
                    loading.value = false;
                    if (res.code == 0) {
                        emit("success", res.data);
                        if (props.isHouxu) {
                            ElMessage.success("更新成功");
                            router.go(-1);
                        }
                    } else {
                        ElMessageBox.alert(res.msg);
                    }
                },
                (err) => {
                    loading.value = false;
                    ElMessageBox.alert(err.message);
                }
            );
        });
    };
</script>

<style scoped lang="scss">
    .views-gerenjiankangshuju-updt {
    }
</style>
