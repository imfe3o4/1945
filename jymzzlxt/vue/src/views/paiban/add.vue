<template>
    <div class="views-paiban-add">
        <div>
            <el-card class="box-card">
                <template #header>
                    <div class="clearfix">
                        <span class="title"> 添加排班 </span>
                    </div>
                </template>

                <el-form :model="form" ref="formModel" :label-width="labelWidth" status-icon validate-on-rule-change>
                    <el-form-item v-if="isRead" label="账号" prop="zhanghao"> {{ form.zhanghao }} </el-form-item>

                    <el-form-item v-if="isRead" label="姓名" prop="xingming"> {{ form.xingming }} </el-form-item>

                    <el-form-item v-if="isRead" label="职称" prop="zhicheng"> {{ form.zhicheng }} </el-form-item>

                    <el-form-item label="上班时间" prop="shangbanshijian" required :rules="[{required:true, message:'请填写上班时间'}]">
                        <el-time-picker v-model="form.shangbanshijian" value-format="HH:mm" placeholder="选择时间"> </el-time-picker>
                    </el-form-item>

                    <el-form-item label="下班时间" prop="xiabanshijian" required :rules="[{required:true, message:'请填写下班时间'}]">
                        <el-time-picker v-model="form.xiabanshijian" value-format="HH:mm" placeholder="选择时间"> </el-time-picker>
                    </el-form-item>

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
    import { usePaibanCreateForm, canPaibanInsert } from "@/module";

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
    const { form, readMap } = usePaibanCreateForm(props.id);
    const emit = defineEmits(["success"]);
    const formModel = ref();
    const loading = ref(false);
    var submit = () => {
        return new Promise((resolve, reject) => {
            formModel.value
                .validate()
                .then((res) => {
                    if (loading.value) return;
                    loading.value = true;
                    canPaibanInsert(form).then(
                        (res) => {
                            loading.value = false;
                            if (res.code == 0) {
                                emit("success", res.data);
                                if (props.isHouxu) {
                                    ElMessage.success("添加成功");
                                    router.go(-1);
                                }
                            } else {
                                ElMessageBox.alert(res.msg);
                            }
                            resolve(res);
                        },
                        (err) => {
                            loading.value = false;
                            ElMessageBox.alert(err.message);
                            reject(err);
                        }
                    );
                })
                .catch((err) => {
                    reject(err);
                });
        });
    };
</script>

<style scoped lang="scss">
    .views-paiban-add {
    }
</style>
