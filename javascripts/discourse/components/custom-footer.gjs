import Component from "@glimmer/component";
import PluginOutlet from "discourse/components/plugin-outlet";
import concatClass from "discourse/helpers/concat-class";
import icon from "discourse/helpers/d-icon";
import dasherize from "discourse/helpers/dasherize";

export default class extends Component {
  mainHeading = settings.heading;
  blurb = settings.blurb;

  <template>
    {{#if @showFooter}}
      <div class="wrap">
        <div class="flexbox">
          <div class="first-box">
            <div class="heading">
              {{this.mainHeading}}
            </div>
            <div class="blurb">
              {{this.blurb}}
            </div>
            <div align="center">
              <form action="https://www.paypal.com/donate" method="post" target="_top">
                <input type="hidden" name="hosted_button_id" value="J95MCLZMU9T9A" />
                <input
                  type="image"
                  src="https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif"
                  border="0"
                  name="submit"
                  title="PayPal - The safer, easier way to pay online!"
                  alt="Donate with PayPal button"
                />
                <img
                  alt=""
                  border="0"
                  src="https://www.paypal.com/en_US/i/scr/pixel.gif"
                  width="1"
                  height="1"
                />
              </form>
            </div>
          </div>
          <div class="second-box">
            <PluginOutlet @name="easy-footer-second-box">
              <div class="links">
                {{#each settings.sections as |section|}}
                  <div
                    class="list"
                    data-easyfooter-section={{dasherize section.text}}
                  >
                    <span title={{section.title}}>
                      {{section.text}}
                    </span>

                    <ul>
                      {{#each section.links as |link|}}
                        <li
                          class="footer-section-link-wrapper"
                          data-easyfooter-link={{dasherize link.text}}
                        >
                          <a
                            class="footer-section-link"
                            title={{link.title}}
                            href={{link.url}}
                            target={{link.target}}
                            referrerpolicy={{link.referrer_policy}}
                          >
                            {{link.text}}
                          </a>
                        </li>
                      {{/each}}
                    </ul>
                  </div>
                {{/each}}
              </div>
            </PluginOutlet>
          </div>

          <div class="third-box">
            <div class="footer-links">
              {{#each settings.small_links as |link|}}
                <a
                  class={{concatClass "small-link" link.css_class}}
                  data-easyfooter-small-link={{dasherize link.text}}
                  target={{link.target}}
                  href={{link.url}}
                >
                  {{link.text}}
                </a>
              {{/each}}
            </div>

            <div class="social">
              <a
                class="small-link"
                href="//lotuselan.net/terms-and-conditions#copy"
              >&copy; Copyright 1999-2025</a>
              {{#each settings.social_links as |link|}}
                <a
                  class="social-link"
                  data-easyfooter-social-link={{dasherize link.text}}
                  title={{link.title}}
                  target={{link.target}}
                  href={{link.url}}
                >
                  {{icon link.icon_name}}
                </a>
              {{/each}}
            </div>
          </div>
        </div>
      </div>
    {{/if}}
  </template>
}
