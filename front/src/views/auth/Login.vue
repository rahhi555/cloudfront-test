<script setup lang="ts">
import { reactive } from "vue";
import { useAuth } from "@/stores/auth";
import { useRouter } from "vue-router";
import { useSnackBar } from "@/composables/useSnackBar";

const { push } = useRouter();
const { show } = useSnackBar();

const params = reactive({
  email: "",
  password: "",
});

const login = () => {
  useAuth()
    .login(params)
    .then(() => {
      push("/");
      show("ログインしました");
    })
    .catch((e) => {
      console.error(e)
      show("ログインに失敗しました");
    });
  ;
}
</script>

<template>
  <div>
    <form>
      <label>
        <span>メールアドレス</span>
        <input type="text" v-model="params.email" />
      </label>
      <label>
        <span>パスワード</span>
        <input type="password" v-model="params.password" />
      </label>
      <button @click.prevent="login">ログイン</button>
    </form>
  </div>
</template>