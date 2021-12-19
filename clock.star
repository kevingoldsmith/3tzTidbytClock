load("render.star", "render")
load("time.star", "time")
load("encoding/base64.star", "base64")


def colorFortime(timeQuery):
    colorMorning = "#FF0"
    colorEvening = "#80F"

    return colorMorning if (timeQuery.hour < 12) else colorEvening


def main(config):
    timezonePT = config.get("timezone") or "America/Los_Angeles"
    timezoneCT = "America/Chicago"
    timezoneCET = "Europe/Berlin"
    nowPT = time.now().in_location(timezonePT)
    nowCT = nowPT.in_location(timezoneCT)
    nowCET = nowPT.in_location(timezoneCET)
    displayFont="6x13"
    wa_map = base64.decode("""iVBORw0KGgoAAAANSUhEUgAAADUAAAAgCAYAAACy/TBYAAAACXBIWXMAAFwfAABcHwFUbPxjAAAFG2lUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNy4xLWMwMDAgNzkuZGFiYWNiYiwgMjAyMS8wNC8xNC0wMDozOTo0NCAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczpkYz0iaHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8iIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0RXZ0PSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VFdmVudCMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIDIyLjUgKE1hY2ludG9zaCkiIHhtcDpDcmVhdGVEYXRlPSIyMDIxLTEyLTE5VDE0OjE4OjAzLTA4OjAwIiB4bXA6TW9kaWZ5RGF0ZT0iMjAyMS0xMi0xOVQxNDozMDo0My0wODowMCIgeG1wOk1ldGFkYXRhRGF0ZT0iMjAyMS0xMi0xOVQxNDozMDo0My0wODowMCIgZGM6Zm9ybWF0PSJpbWFnZS9wbmciIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJzUkdCIElFQzYxOTY2LTIuMSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDo5ZjE5OTg1Zi0xYzEx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""")
    tx_map = base64.decode("""iVBORw0KGgoAAAANSUhEUgAAACMAAAAgCAYAAACYTcH3AAAACXBIWXMAAA8SAAAPEgEhm/IzAAAF+GlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNy4xLWMwMDAgNzkuZGFiYWNiYiwgMjAyMS8wNC8xNC0wMDozOTo0NCAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczpkYz0iaHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8iIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0RXZ0PSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VFdmVudCMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIDIyLjUgKE1hY2ludG9zaCkiIHhtcDpDcmVhdGVEYXRlPSIyMDIxLTEyLTE5VDE0OjE3OjM0LTA4OjAwIiB4bXA6TW9kaWZ5RGF0ZT0iMjAyMS0xMi0xOVQxNDozOTo0Mi0wODowMCIgeG1wOk1ldGFkYXRhRGF0ZT0iMjAyMS0xMi0xOVQxNDozOTo0Mi0wODowMCIgZGM6Zm9ybWF0PSJpbWFnZS9wbmciIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJzUkdCIElFQzYxOTY2LTIuMSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDo1OTk1OGZjMy0yOTQ0LTRhNmQtYjRmNi0zYzc3Mzg2NzY0NWEiIHhtcE1NOkRvY3VtZW50SUQ9ImFkb2JlOmRvY2lkOnBob3Rvc2hvcDplMDc4OTEyMC0zOGNiLTU1NDYtODAwMy0zYjczMTI3NDU1NTciIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDo0YWU2MTJjYi01MjljLTQ2MTEtOTk5ZC0wYWU2MzNmNDc5OGUiPiA8eG1wTU06SGlzdG9yeT4gPHJkZjpTZXE+IDxyZGY6bGkgc3RFdnQ6YWN0aW9uPSJjcmVhdGVkIiBzdEV2dDppbnN0YW5jZUlEPSJ4bXAuaWlkOjRhZTYxMmNiLTUyOWMtNDYxMS05OTlkLTBhZTYzM2Y0Nzk4ZSIgc3RFdnQ6d2hlbj0iMjAyMS0xMi0xOVQxNDoxNzozNC0wODowMCIgc3RFdnQ6c29mdHdhcmVBZ2VudD0iQWRvYmUgUGhvdG9zaG9wIDIyLjUgKE1hY2ludG9zaCkiLz4gPHJkZjpsaSBzdEV2dDphY3Rpb249InNhdmVkIiBzdEV2dDppbnN0YW5jZUlEPSJ4bXAuaWlkOjU5OTU4ZmMzLTI5NDQtNGE2ZC1iNGY2LTNjNzczODY3NjQ1YSIgc3RFdnQ6d2hlbj0iMjAyMS0xMi0xOVQxNDozOTo0Mi0wODowMCIgc3RFdnQ6c29mdHdhcmVBZ2VudD0iQWRvYmUgUGhvdG9zaG9wIDIyLjUgKE1hY2ludG9zaCkiIHN0RXZ0OmNoYW5nZWQ9Ii8iLz4gPC9yZGY6U2VxPiA8L3htcE1NOkhpc3Rvcnk+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+SFrSFwAAAdRJREFUWMPV1ztrFGEUh/HfrgaNGrHRxl6xEa8IKlbaJTZaWohKGoOpbPwAFqIIQkRES/FSCIKC4GUtLIKYRtAmSaGNN5BoFCO6xuYsLMMMO5vszqx/eJnhPQfmgXOdSm1gnxw6huv4gb8J2wBu4IhFamlOv9XxXJlh79cBVTsEvbxImBUt7MuKhKkqQJ36SH8vwezGCwxjYxuFsaBqyqOdceATZvAWLwN0IqpybVTlR0ziazdgmrUuzgYciN5UR1+K73OcxnghiRnp0Jdh2xswioLpnZL932CWNBJ4GLOYQ6XJoR5Z/wVbuwyzvgFzoqkky9IODFajYY31QKhOVfEHIxgtGWZXcwJfwiF8LgnmW7Ka7uJgSTDv00p7POZI0ZrM6jO3Uu5e4TCGcDFlF25X83jTCBEuZA3K89gUi3hDo3gW7/djEt9cBEwFV1HDa9QrLf4O1uABVmFbNMJm7cejBcJcxsl2xsFMTNUtKSDwGPfaCMuv6PYjSZC8s2k+Tpau5IR5gu3R+se6NSgf4k4Lnzkcj9yY7fbUPpMRxoaO4l1RK8Q0zmXYnuJ20fvMWXxIua+VsVx9D6Ckfpe16V3DVOJuqCyYn9iMwdj4J7AndqaW+gcFc1f1ltaf+QAAAABJRU5ErkJggg==""")
    de_map = base64.decode("""iVBORw0KGgoAAAANSUhEUgAAABoAAAAgCAYAAAAMq2gFAAAACXBIWXMAAAsTAAALEwEAmpwYAAAGx2lUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNy4xLWMwMDAgNzkuZGFiYWNiYiwgMjAyMS8wNC8xNC0wMDozOTo0NCAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczpkYz0iaHR0cDovL3B1cmwub3JnL2RjL2VsZW1lbnRzLzEuMS8iIHhtbG5zOnBob3Rvc2hvcD0iaHR0cDovL25zLmFkb2JlLmNvbS9waG90b3Nob3AvMS4wLyIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0RXZ0PSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VFdmVudCMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIDIyLjUgKE1hY2ludG9zaCkiIHhtcDpDcmVhdGVEYXRlPSIyMDIxLTEyLTE5VDE0OjE4OjMzLTA4OjAwIiB4bXA6TW9kaWZ5RGF0ZT0iMjAyMS0xMi0xOVQxNDo1NDoxNy0wODowMCIgeG1wOk1ldGFkYXRhRGF0ZT0iMjAyMS0xMi0xOVQxNDo1NDoxNy0wODowMCIgZGM6Zm9ybWF0PSJpbWFnZS9wbmciIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJzUkdCIElFQzYxOTY2LTIuMSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDphNTQ0MzM4Ny1mZjIyLTRjOGUtYjExYy0xZTQ4MmZiYTYxNjQiIHhtcE1NOkRvY3VtZW50SUQ9ImFkb2JlOmRvY2lkOnBob3Rvc2hvcDo2ZWFhODgyYS0xNjVjLTEzNGYtYTM2Zi1hM2Q0ZjE3NGU4MTkiIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDo3MGMzOWNiYi1hODEyLTQ3NDgtODllMi1jYzEzMDJkZTc2YzgiPiA8eG1wTU06SGlzdG9yeT4gPHJkZjpTZXE+IDxyZGY6bGkgc3RFdnQ6YWN0aW9uPSJjcmVhdGVkIiBzdEV2dDppbnN0YW5jZUlEPSJ4bXAuaWlkOjcwYzM5Y2JiLWE4MTItNDc0OC04OWUyLWNjMTMwMmRlNzZjOCIgc3RFdnQ6d2hlbj0iMjAyMS0xMi0xOVQxNDoxODozMy0wODowMCIgc3RFdnQ6c29mdHdhcmVBZ2VudD0iQWRvYmUgUGhvdG9zaG9wIDIyLjUgKE1hY2ludG9zaCkiLz4gPHJkZjpsaSBzdEV2dDphY3Rpb249InNhdmVkIiBzdEV2dDppbnN0YW5jZUlEPSJ4bXAuaWlkOmVlMzBkYzRiLWNiYTktNDVmMS04ZDRiLTMxZDMyNzM0ZjNiYSIgc3RFdnQ6d2hlbj0iMjAyMS0xMi0xOVQxNDo0ODo0Mi0wODowMCIgc3RFdnQ6c29mdHdhcmVBZ2VudD0iQWRvYmUgUGhvdG9zaG9wIDIyLjUgKE1hY2ludG9zaCkiIHN0RXZ0OmNoYW5nZWQ9Ii8iLz4gPHJkZjpsaSBzdEV2dDphY3Rpb249InNhdmVkIiBzdEV2dDppbnN0YW5jZUlEPSJ4bXAuaWlkOmE1NDQzMzg3LWZmMjItNGM4ZS1iMTFjLTFlNDgyZmJhNjE2NCIgc3RFdnQ6d2hlbj0iMjAyMS0xMi0xOVQxNDo1NDoxNy0wODowMCIgc3RFdnQ6c29mdHdhcmVBZ2VudD0iQWRvYmUgUGhvdG9zaG9wIDIyLjUgKE1hY2ludG9zaCkiIHN0RXZ0OmNoYW5nZWQ9Ii8iLz4gPC9yZGY6U2VxPiA8L3htcE1NOkhpc3Rvcnk+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+nGMl8QAAAvNJREFUSMetlrtrFFEUxn/nzuhGEUPYNYVPVFIoiJIEjIio4KtTMJDGQgvFCIr+AdpYqGCljSLEQkGEgAp2dsGo4AMsfAcxUaOJG4NGV5LsvcdiZtedzZrNzu5pZgbmnu9893znIaqKSIqcpSlpWvAuVGhJTWNm+nMzuAJQrRTMVPJvcwCYZ3kJNpyHzUUBlAxkxkDPouwswGF44AdMFaAFfjZXySifl4Hg4eUcHoeeHLjC/AI2EWYlgdKwEuAOuu4JrCq+ioEAOdsKwy0wEYJ6YRBSdMUA+MHDRUiOgpcC3V0gsOKD/cHZxuIgQzCWlgaKWhO8LeV8gPjml0tVNc5LiMFRIB6uQFu1jgV+TWG0CxhD6CXLI/zVB5GHACuAOTGBFsK8CLCqgjSAwA2y7NAE80QvZ9Ucsmjl/Sbas0Yn0Q1JHXkjqsqQNCCwOGVkVJSGETUfAE9qkBvfuNZ6+/2pDyDGoZhFX535CPwAvBppIJvFfqzPiUEwCLwkSGA9NTPxrcr2vOqyarDOHKAogdWaAqh/Mq86EbfRqTlBbW1c0BER/ZJn5MGwCENaO5BP4Drr/D9rjLGdeSAH7wRu1wDgt4jr9IxdItirntjvAq/zV6fOrHWwkzijM7A+H9fuMfncqsGpD2ikCn0AC3sV2VIFE8+hfQI4FMUFDe1fVwuAkt2clTqSGI7EpLRc1XTArC5mg4iQuaxoN9jQoQ9Qt0cyOO4DR+KXjGlD6CJUV2IbTNydQ+JFQa+z/SmABHAP2BQSlhjN7SJwLHdaGgUzV4HoujUObCWY+63A6UrnAsJRhGuY4Fu/Kba/9IS1wBjKM4TlMS9xXzhd2stvQUIL0B0T6D1wYabr1v6YIFfDOdozJXZVxX5IFTP6HAzJimwiXH6GphTZstK79+oCkOvAHSBTBuQVMBs4NP0WFBXyINARRvYYyKAsCPN2Bkij3EI4B5xCuQkMIjQB6/8ryoI6mr5GgmDWo/govRgaUYaR8lXnLUvzFxMk/ih1Ln4LAAAAAElFTkSuQmCC""")

    return render.Root(
        delay = 2000,
        child = render.Box(
            child = render.Animation(
                children = [
                    render.Stack(
                        children = [
                            render.Box(
                                height=32,
                                width=64,
                                child=render.Image(src=wa_map)
                            ),
                            render.Box(
                                height=32,
                                width=64,
                                child=render.Column(
                                    children = [
                                        render.Text(
                                            content = "Seattle",
                                            font = displayFont
                                        ),
                                        render.Text(
                                            content = nowPT.format("3:04 PM"),
                                            font = displayFont,
                                            color = colorFortime(nowPT)
                                        ),
                                    ]
                                )
                            )
                        ]
                    ),
                    render.Stack(
                        children = [
                            render.Box(
                                height=32,
                                width=64,
                                child=render.Image(src=tx_map)
                            ),
                            render.Box(
                                height=32,
                                width=64,
                                child=render.Column(
                                    children = [
                                        render.Text(
                                            content = "Austin",
                                            font=displayFont
                                        ),
                                        render.Text(
                                            content = nowCT.format("3:04 PM"),
                                            font = displayFont,
                                            color = colorFortime(nowCT)
                                        )
                                    ]
                                )
                            )
                        ]
                    ),
                    render.Stack(
                        children = [
                            render.Box(
                                height=32,
                                width=64,
                                child=render.Image(src=de_map)
                            ),
                            render.Box(
                                child=render.Column(
                                    children = [
                                        render.Text(
                                            content="Berlin",
                                            font=displayFont
                                        ),
                                        render.Text(
                                            content = nowCET.format("3:04 PM"),
                                            font = displayFont,
                                            color = colorFortime(nowCET)
                                        )
                                    ]
                                )
                            )
                        ]
                    )
                ],
            ),
        )
    )
