import { createFileRoute } from '@tanstack/react-router'
import { Link, Outlet } from '@tanstack/react-router'

export const Route = createFileRoute('/install')({
  component: InstallPage,
})

/**
 * 服务安装页面
 */
function InstallPage() {
  return (
    <div className="p-2 flex gap-2">
      <div className="flex flex-col">
        Install Software:
        <Link
          to="/install/$step"
          params={{ step: 'stpe1' }}
          className="text-sky-500"
          activeProps={{
            className: 'font-bold',
          }}>
          Step1
        </Link>{' '}
        <Link
          to="/install/$step"
          params={{ step: 'stpe2' }}
          className="text-sky-500"
          activeProps={{
            className: 'font-bold',
          }}>
          Step2
        </Link>{' '}
      </div>
      <div className="p-10">
        <Outlet />
      </div>
    </div>
  )
}
