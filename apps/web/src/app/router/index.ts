import DashboardPage from "@/ui/components/pages/dashboard/DashboardPage.vue";
import LoginPage from "@/ui/components/pages/login/LoginPage.vue";
import RegisterPage from "@/ui/components/pages/register/RegisterPage.vue";
import SquadPage from "@/ui/components/pages/squad/SquadPage.vue";
import { useApi } from "@/ui/hooks";
import { createRouter, createWebHistory } from "vue-router";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "home",
      component: DashboardPage,
    },
    {
      path: "/login",
      name: "Login",
      component: LoginPage,
    },
    {
      path: "/register",
      name: "Register",
      component: RegisterPage,
    },
    {
      path: "/squads/:id",
      name: "Squad",
      component: SquadPage,
    },
  ],
});
router.beforeEach((to, from, next) => {
  const token = localStorage.getItem("jwt");
  if (to.name === "Login" || to.name === "Register") {
    next();
  } else if (token) {
    next();
  } else {
    next("login");
  }
});
export default router;
