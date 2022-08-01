import SnackBarVue from "@/components/templates/SnackBar.vue";
import { reactive, readonly } from "vue";
const snackBarStatus = reactive({
  isVisible: false,
  message: "",
})

const resetSnackBarStatus = () => {
  snackBarStatus.isVisible = false;
  snackBarStatus.message = "";
}

export const useSnackBar = () => {
  return {
    snackBarStatus: readonly(snackBarStatus),
    show: (msg: string) => {
      snackBarStatus.isVisible = true;
      snackBarStatus.message = msg;

      setTimeout(resetSnackBarStatus, 2000);
    }
  };
}