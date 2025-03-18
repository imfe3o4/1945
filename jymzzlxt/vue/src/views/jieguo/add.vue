<template>
    <div class="views-jieguo-add">
        <div>
            <el-card class="box-card">
                <template #header>
                    <div class="clearfix">
                        <span class="title"> 添加结果 </span>
                    </div>
                </template>

                <el-form :model="form" ref="formModel" :label-width="labelWidth" status-icon validate-on-rule-change>
                    <el-form-item v-if="isRead" label="试卷编号" prop="shijuanbianhao"> {{ form.shijuanbianhao }} </el-form-item>

                    <el-form-item v-if="isRead" label="试卷名称" prop="shijuanmingcheng"> {{ form.shijuanmingcheng }} </el-form-item>

                    <el-form-item v-if="isRead" label="发布人" prop="faburen"> {{ form.faburen }} </el-form-item>

                    <el-form-item v-if="isRead" label="答题类型" prop="datileixing"> {{ form.datileixing }} </el-form-item>

                    <el-form-item label="考试编号" prop="kaoshibianhao" :rules="[{required:true, message:'请填写考试编号'}]">
                        <el-input type="text" placeholder="输入考试编号" style="width: 450px" v-model="form.kaoshibianhao" />
                    </el-form-item>

                    <el-form-item label="试题题目" prop="shititimu"> <el-input type="textarea" v-model="form.shititimu"></el-input> </el-form-item>

                    <el-form-item label="类型" prop="leixing"> <el-input type="text" placeholder="输入类型" style="width: 450px" v-model="form.leixing" /> </el-form-item>

                    <el-form-item label="答案" prop="daan"> <el-input type="textarea" v-model="form.daan"></el-input> </el-form-item>

                    <el-form-item label="得分" prop="defen" :rules="[{validator:rule.checkNumber, message:'输入一个有效数字'}]">
                        <el-input type="number" placeholder="输入得分" style="width: 450px" v-model.number="form.defen" />
                    </el-form-item>

                    <el-form-item label="答题人" prop="datiren"> <el-input v-model="form.datiren" readonly style="width: 250px"></el-input> </el-form-item>

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
    import { useJieguoCreateForm, canJieguoInsert } from "@/module";

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
    const { form, readMap } = useJieguoCreateForm(props.id);
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
                    canJieguoInsert(form).then(
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
    .views-jieguo-add {
    }
</style>
