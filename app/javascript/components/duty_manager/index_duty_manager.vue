<template>
  <section class="b-tooltips">
    <div class="box" style="margin-top: 60px; margin-left: 300px; margin-right: 300px;">
      <h1>Personas asociada a la facultad</h1>
      <b-tabs>
        <b-tab-item label="Personas registradas">
          <div class="has-text-right">
            <b-button label="Añadir Persona asociada" type="is-info" icon-left="plus" @click="createDutyManager()">
            </b-button>
          </div>
         
         <div>
            <b-modal :active="isModalActiveShow" aria-modal has-modal-card :destroy-on-hide="true" aria-role="dialog"
              width="100%" :can-cancel="canCancel">
              <template>
                <show-duty-manager modal-cancel="true" :id="selected" :modal-header="'Detalle de la persona asociada'"
                  @close="closeModalShow"></show-duty-manager>
              </template>
            </b-modal>

            <b-modal :active="isModalActive" aria-modal has-modal-card :destroy-on-hide="true" aria-role="dialog"
              width="100%" :can-cancel="canCancel">
              <template>
                <new-duty-manager modal-cancel="true" :modal-header="'Registro de Persona asociada'" query-type="create"
                  @close="closeModalCreate"></new-duty-manager>
              </template>
            </b-modal>

            <b-modal :active="isModalActiveEdit" aria-modal has-modal-card :destroy-on-hide="true" aria-role="dialog"
              width="100%" :can-cancel="canCancel">
              <template>
                <edit-duty-manager :duty_manager-id="duty_managerId" :id="selected" :modal-header="'Editar información de la persona'" query-type="update"
                  @close="closeModalEdit"></edit-duty-manager>
              </template>
            </b-modal>

          </div>


          <div class="column">
            <b-table :data="managers" :paginated=true per-page="8" striped hoverable :pagination-simple=false
              pagination-position="bottom" default-sort-direction="asc" sort-icon="arrow-up" sort-icon-size="is-small"
              default-sort="inventores.name" aria-next-label="Siguiente" aria-previous-label="Anterior"
              aria-page-label="Página" aria-current-label="Página actual">

              <b-table-column :visible=false field="id" label="ID" sortable searchable>

                <template v-slot="props">
                  {{ props.row.id }}
                </template>



              </b-table-column>

              <b-table-column field="name_duty_manager" label="Nombre del Peronal" sortable searchable>

                <template v-slot="props">
                  <a href="#" @click="Clickshowdutymanager(props.row.id)">{{ props.row.name_duty_manager }}</a>
                </template>
              </b-table-column>

              <b-table-column field="rut" label="Rut" sortable searchable>

                <template v-slot="props">
                  {{ props.row.rut }}
                </template>
              </b-table-column>

              <b-table-column field="unit.name_unit" label="Nombre Unidad" sortable searchable>

                <template v-slot="props">
                  <a href="#" @click="Clickshowunit(props.row.unit_id)">{{ props.row.unit.name_unit }}</a>
                </template>
              </b-table-column>


                            <b-table-column ffield="id" width="10" label="Acciones" v-slot="props" size="is-small">
                <div class="columns">
                  <div class="column">
                   <b-tooltip label="Ver detalle" type="is-info">
                <b-icon pack="fas" icon="eye" size="is-medium"
              @click.native="Clickshowdutymanager(props.row.id)"/>
              </b-tooltip>
                  </div>
                  <div class="column">
                    <b-tooltip label="Anular" type="is-info">
                      <b-icon pack="fas" icon="trash" size="is-medium"
                        @click.native="confirmisempty(props.row.id)" />
                    </b-tooltip>
                  </div>
                  <div class="column">
                    <b-tooltip label="Editar" type="is-info">
                      <b-icon pack="fas" icon="pen" size="is-medium" @click.native="editManager(props.row.id)" />
                    </b-tooltip>
                  </div>
                </div>
              </b-table-column>

            </b-table> 
          </div>
        </b-tab-item>





        <b-tab-item label="Personas asociadas en papelera">
          <div class="column">
            <b-table :data="null_managers" :paginated=true per-page="8" striped hoverable :pagination-simple=false
              pagination-position="bottom" default-sort-direction="asc" sort-icon="arrow-up" sort-icon-size="is-small"
              default-sort="inventores.name" aria-next-label="Siguiente" aria-previous-label="Anterior"
              aria-page-label="Página" aria-current-label="Página actual">

              <b-table-column :visible=false field="id" label="ID" sortable searchable>

                <template v-slot="props">
                  {{ props.row.id }}
                </template>



              </b-table-column>

              <b-table-column field="name_duty_manager" label="Nombre del Peronal" sortable searchable>

                <template v-slot="props">
                  <a href="#" @click="Clickshowdutymanager(props.row.id)">{{ props.row.name_duty_manager }}</a>
                </template>
              </b-table-column>

              <b-table-column field="rut" label="Rut" sortable searchable>

                <template v-slot="props">
                  {{ props.row.rut }}
                </template>
              </b-table-column>

              <b-table-column field="unit.name_unit" label="Nombre Unidad" sortable searchable>

                <template v-slot="props">
                  <a href="#" @click="Clickshowunit(props.row.unit_id)">{{ props.row.unit.name_unit }}</a>
                </template>
              </b-table-column>


              <b-table-column ffield="id" width="10" label="Acciones" v-slot="props" size="is-small">

                <div class="columns">
                  <div class="column">
                   <b-tooltip label="Ver detalle" type="is-info">
                <b-icon
              pack="fas"
              icon="eye"
              size="is-medium"
              @click.native="Clickshowdutymanager(props.row.id)"/>
              </b-tooltip>
                  </div>
                  <div class="column" v-show='!(props.row.unit.active_unit == 0)'>
                    <b-tooltip label="Restaurar" type="is-info">
                      <b-icon pack="fas" icon="trash-arrow-up" size="is-medium"
                        @click.native="confirmGoodRest(props.row.id)" />
                    </b-tooltip>
                  </div>

                  <div class="column" v-show='(props.row.unit.active_unit == 0)'> 
                    <b-tooltip label="No  se puede Restaurar" type="is-info">
                      <b-icon pack="fas" icon="trash-arrow-up" type="is-danger" size="is-medium"/>
                    </b-tooltip>
                  </div>

                </div>
              </b-table-column>
            </b-table>
          </div>
        </b-tab-item>



      </b-tabs>
    </div>
  </section>
</template>


<script>
import axios from "axios";
import NewDutyManager from './new_duty_manager.vue';
import ShowDutyManager from './show_duty_manager.vue';
import EditDutyManager from "./edit_duty_manager.vue";
export default {
  components: { NewDutyManager, ShowDutyManager, EditDutyManager },
  data() {
    return {
      managers: [],
      goods: [],
      id_goods_list: [],
      null_managers: [],
      goods_duty_manager: [],
      offices_duty_manager: [],
      buildings_duty_manager: [],
      canCancel: ["escape"],
      isModalActive: false,
      isModalActiveShow: false,
      isModalActiveEdit: false,
      selected: null,
      null_active: 0,
      des_active: 1,
      pendiing_good: 2,
    };
  },
  props: ["duty_managerId"],
  methods: {

        async getdutymanageractive() {
      const response = await axios.get("/duty_managers/showactivedutymanager.json");
      this.managers = response.data;
    },

        async null_getdutymanager() {
      const response = await axios.get("/duty_managers/shownulldutymanager.json");
      this.null_managers = response.data;
    },




    confirmisempty(item){
      this.getgoodbydutymanagernull(item);
    },



        async getgoodbydutymanagernull(item) {
      const response = await axios.get("/goods/showgoodutymanager/" + item + ".json");
      this.goods_duty_manager = response.data;
      console.log(this.goods_duty_manager);
      if (this.goods_duty_manager.length == 0) {
        console.log(this.goods_duty_manager.length);
        this.getofficebydutymanager(item);
        }
        else{
          this.$buefy.dialog.alert({
                    title: 'No se puede anular',
                    type: 'is-danger',
                    message: 'Existen bienes designados a la persona asociada',
                    confirmText: 'Aceptar'
                })
        }
    },

    async getofficebydutymanager(item) {
      const response = await axios.get("/offices/showofficedutymanager/" + item + ".json");
      this.offices_duty_manager = response.data;
      console.log(this.offices_duty_manager);
      if (this.offices_duty_manager.length == 0) {
        console.log(this.offices_duty_manager);
        this.getobuildingbydutymanager(item);
        }
        else{
          this.$buefy.dialog.alert({
                    title: 'No se puede anular',
                    type: 'is-danger',
                    message: 'Existen dependencias designados a la persona asociada',
                    confirmText: 'Aceptar'
                })
        }
    },

    async getobuildingbydutymanager(item) {
      const response = await axios.get("/buildings/showbuildingdutymanager/" + item + ".json");
      this.buildings_duty_manager = response.data;
      console.log(this.buildings_duty_manager);
      if (this.buildings_duty_manager.length == 0) {
        console.log(this.buildings_duty_manager.length);
        this.confirmGoodNull(item);
        }
        else{
          this.$buefy.dialog.alert({
                    title: 'No se puede anular',
                    type: 'is-danger',
                    message: 'Existen edificios designados a la persona asociada',
                    confirmText: 'Aceptar'
                })
        }
    },

    async RestClick(item) {
      const response = await axios.put("/duty_managers/" + item + ".json", {
        active_duty_manager: this.des_active,
      });
      window.location.href = "/duty_managers";
    },
    confirmGoodRest(item) {
      this.$buefy.dialog.confirm({
        title: "Restaurar Unidad",
        message: "¿Esta seguro de querer restaurar la Unidad?.",
        confirmText: "Restaurar",
        cancelText: "Cancelar",
        type: "is-danger",
        hasIcon: true,
        onConfirm: () => this.RestClick(item),
      });
    },

    confirmGoodNull(item) {
      this.$buefy.dialog.confirm({
        title: "Anular Unidad",
        message: "¿Esta seguro de querer anular la Unidad?.",
        confirmText: "Anular",
        cancelText: "Cancelar",
        type: "is-danger",
        hasIcon: true,
        onConfirm: () => this.AnulClick(item),
      });
    },

         async AnulClick(item) {
      const response = await axios.put("/duty_managers/" + item + ".json", {
        active_duty_manager: this.null_active,
      });
      window.location.href = "/duty_managers";
    },

        async AnulClickgood(item) {
      const response = await axios.put("/goods/" + item + ".json", {
        activegood: this.pendiing_good,
      });
    },

    async getgoodbydutymanager(item) {
      const response = await axios.get("/goods/showgoodutymanager/" + item + ".json");
      this.goods = response.data;
    },


    async editManager(item) {
      this.selected = item;
      this.isModalActiveEdit = true;
    },
    async closeModalEdit() {
      this.isModalActiveEdit = false;
    },

    async Clickshowunit(item) {
      const response = (window.location.href = "/units/" + item);
    },
    async Clicknewdutymanager() {
      const response = (window.location.href = "/duty_managers/new");
    },
    async Clickshowdutymanager(item) {
      const response = (window.location.href = "/duty_managers/" + item);
    },
    async createDutyManager() {
      this.isModalActive = true;
    },
    async closeModalCreate() {
      this.isModalActive = false;
    },
    async ShowModaleDutyManager(item) {
      this.selected = item;
      this.isModalActiveShow = true;
    },
    async closeModalShow() {
      this.isModalActiveShow = false;
    },

  },
  created() {
    this.getdutymanageractive();
    this.null_getdutymanager();
  },
};
</script>