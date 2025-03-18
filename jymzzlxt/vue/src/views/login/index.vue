<template>
    <div class="login-wrap">
        <div class="ms-login">
            <div class="ms-title">登录系统</div>
            <el-form :model="param" :rules="rules" ref="login" label-width="0px" class="ms-content">
                <el-form-item prop="username">
                    <el-input icon="User" v-model="param.username" placeholder="输入用户名">
                        <template #prepend>
                            <el-icon>
                                <el-icon-user />
                            </el-icon>
                        </template>
                        <template #append>
                            <el-dropdown>
                                <span class="el-dropdown-link" style="cursor: pointer"> {{ param.cx }} <i class="el-icon-arrow-down el-icon--right"></i> </span>
                                <template #dropdown>
                                    <el-dropdown-menu>
                                        <el-dropdown-item v-for="r in roles" @click.native="param.cx = r" :key="r">{{ r }} </el-dropdown-item>
                                    </el-dropdown-menu>
                                </template>
                            </el-dropdown>
                        </template>
                    </el-input>
                </el-form-item>
                <el-form-item prop="pwd">
                    <el-input type="password" placeholder="输入密码" v-model="param.pwd" @keyup.enter.native="submitForm()">
                        <template #prepend>
                            <el-icon><el-icon-lock /></el-icon>
                        </template>
                    </el-input>
                </el-form-item>
                <el-form-item prop="pwd" class="pagerandom">
                    <el-input type="password" ref="random" placeholder="输入验证码" v-model="param.pagerandom" @keyup.enter.native="submitForm()"> </el-input>
                    <img
                        alt="刷新验证码"
                        slot="append"
                        title="点击刷新验证码"
                        @click="loadCaptchToInput"
                        :src="captchUrl"
                        unselectable="on"
                        style="cursor: pointer; width: 80px; height: 30px; max-width: none; max-height: none"
                    />
                </el-form-item>

                <div class="login-btn">
                    <el-button type="primary" @click="submitForm()">登录</el-button>
                </div>
                <p class="login-tips">Tips : 请填写账号密码。</p>
            </el-form>
        </div>
    </div>
</template>

<script>
    import config from "@/config";
    import { canLogin } from "@/stores";
    import { captch } from "@/utils/utils";

    export default {
        data: function () {
            return {
                config,
                captchUrl: "",
                param: {
                    username: "",
                    pwd: "",
                    cx: "",
                    pagerandom: "",
                    a: "a",
                },
                showCaptch: false,
                rules: {
                    username: [{ required: true, message: "请输入用户名", trigger: "blur" }],
                    pwd: [{ required: true, message: "请输入密码", trigger: "blur" }],
                    pagerandom: [{ required: true, message: "请输入验证码", trigger: "blur" }],
                },
                roles: ["管理员", "医生", "用户"],
            };
        },
        methods: {
            submitForm() {
                this.$refs.login.validate((valid) => {
                    if (valid) {
                        canLogin(this.param)
                            .then((res) => {
                                this.loading = false;
                                if (res.code == 0) {
                                    this.$message.success("登录成功");
                                    var redirect = this.$route.query.redirect;
                                    if (redirect) {
                                        this.$router.replace(redirect);
                                    } else {
                                        this.$router.replace("/admin/sy");
                                    }
                                } else {
                                    this.$message.error(res.msg);
                                }
                                if (res.code == 20) {
                                    this.loadCaptch();
                                }
                            })
                            .catch((err) => {
                                this.$message.error(err.message);
                            });
                    } else {
                        this.$message.error("请输入账号和密码");
                        console.log("error submit!!");
                        return false;
                    }
                });
            },
            loadCaptchToInput() {
                this.loadCaptch();
                this.param.pagerandom = "";
                this.$refs.random.focus();
            },
            loadCaptch() {
                captch().then((res) => {
                    console.log(res);
                    this.param.captchToken = res.token;
                    this.captchUrl = res.url;
                });
            },
        },
        created() {
            this.loadCaptch();
            this.param.cx = this.roles[0];
        },
    };
</script>

<style lang="scss">
    .login-wrap {
        position: relative;
        width: 100%;
        height: 100%;
        background-image: url(./login-bg.jpg);
        background-size: 100%;

        .pagerandom .el-input-group__append {
            padding: 0px 20px;
        }

        .ms-title {
            width: 100%;
            line-height: 50px;
            text-align: center;
            font-size: 20px;
            color: #fff;
            border-bottom: 1px solid #ddd;
        }

        .ms-login {
            position: absolute;
            left: 50%;
            top: 50%;
            width: 450px;
            margin: -190px 0 0 -175px;
            border-radius: 5px;
            background: rgba(255, 255, 255, 0.3);
            overflow: hidden;

            .el-form-item__error {
                left: 80px;
            }
        }

        .ms-content {
            padding: 30px 30px;
        }

        .login-btn {
            text-align: center;
        }

        .login-btn button {
            width: 100%;
            height: 36px;
            margin-bottom: 10px;
        }

        .login-tips {
            font-size: 12px;
            line-height: 30px;
            color: #fff;
        }
    }
</style>
