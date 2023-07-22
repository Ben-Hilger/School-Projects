import { createRouter, createWebHistory } from 'vue-router'
import EntryView from "@/views/EntryView.vue"
import LoginView from "@/views/LoginView.vue"
import AssetsView from "@/views/AssetsView.vue"
import SettingsView from "@/views/SettingsView.vue"
import POCView from "@/views/POCView.vue"
import Routes from './routes'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    { path: Routes.HOME_ROUTE, name: Routes.HOME_NAME, component: POCView, meta: { requiresAuth: false } },
    // { path: Routes.LOGIN_ROUTE, name: Routes.LOGIN_NAME, component: LoginView, meta: { requiresAuth: false } },
    // { path: Routes.ASSETS_ROUTE, name: Routes.ASSETS_NAME, component: AssetsView, meta: { requiresAuth: true } },
    // { path: Routes.SETTINGS_ROUTE, name: Routes.SETTINGS_NAME, component: SettingsView, meta: { requiresAuth: true }}
  ]
})

// router.beforeEach((route) => {
//   const beforeRouter = new BeforeRouter();
//   if (route.meta.requiresAuth && !beforeRouter.validateUserHasAccess()) {
//     // router.push(Routes.LOGIN_ROUTE)
//   }
// })


export default router
