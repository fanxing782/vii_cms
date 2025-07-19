import { createFileRoute } from '@tanstack/react-router'
import classes from './login.module.css'

export const Route = createFileRoute('/_auth/login')({
  component: LoginPage,
})

/**
 * 登录页
 */
function LoginPage() {
  return (
    <div className={classes.login}>
      <h3>Login Page!</h3>
    </div>
  )
}
